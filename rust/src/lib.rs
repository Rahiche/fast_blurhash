use blurhash::decode;
use image::codecs::png::PngEncoder;
use image::ImageBuffer;
use image::{ExtendedColorType, ImageEncoder, Rgb};
use std::time::Instant;
use std::usize;

#[repr(C)]
pub struct VecU8 {
    ptr: *mut u8,
    len: usize,
    cap: usize,
}

#[no_mangle]
pub extern "C" fn decodeBlurhash(
    blurhash: *const u8,
    length: usize,
    width: u32,
    height: u32,
    punch: f32,
) -> VecU8 {
    // Start time for the whole function
    let start_time = Instant::now();

    let blurhash_str = unsafe {
        match std::str::from_utf8(std::slice::from_raw_parts(blurhash, length)) {
            Ok(s) => s,
            Err(_) => return VecU8 { ptr: std::ptr::null_mut(), len: 0, cap: 0 },
        }
    };

    // Start time for decoding
    let decode_start = Instant::now();

    // Decode the blurhash string
    let pixels = match decode(blurhash_str, width, height, punch) {
        Ok(p) => p,
        Err(_) => return VecU8 { ptr: std::ptr::null_mut(), len: 0, cap: 0 },
    };

    let decode_duration = decode_start.elapsed();
    println!("Decoding took {:?}", decode_duration);

    // Start time for creating image buffer
    let image_buffer_start = Instant::now();

    // Convert the pixel data to an image buffer
    let image_buffer: ImageBuffer<Rgb<u8>, Vec<u8>> =
        match ImageBuffer::from_raw(width, height, pixels) {
            Some(buffer) => buffer,
            None => return VecU8 { ptr: std::ptr::null_mut(), len: 0, cap: 0 },
        };

    let image_buffer_duration = image_buffer_start.elapsed();
    println!("Creating image buffer took {:?}", image_buffer_duration);

    // Start time for encoding PNG
    let encode_start = Instant::now();

    // Encode the image buffer to a PNG
    let mut png_buffer = Vec::new();
    {
        let encoder = PngEncoder::new(&mut png_buffer);

        if encoder
            .write_image(&image_buffer, width, height, ExtendedColorType::Rgba8)
            .is_err()
        {
            return VecU8 { ptr: std::ptr::null_mut(), len: 0, cap: 0 };
        }
    }

    let encode_duration = encode_start.elapsed();
    println!("Encoding PNG took {:?}", encode_duration);

    // Convert the Vec<u8> into VecU8
    let vec_u8 = VecU8 {
        ptr: png_buffer.as_ptr() as *mut u8,
        len: png_buffer.len(),
        cap: png_buffer.capacity(),
    };

    // Prevent Rust from deallocating the vector
    std::mem::forget(png_buffer);

    let total_duration = start_time.elapsed();
    println!("Total function duration was {:?}", total_duration);

    vec_u8
}
