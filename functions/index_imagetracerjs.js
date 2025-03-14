// import { onDocumentUpdated} from "firebase-functions/v2/firestore";
// import { setGlobalOptions } from "firebase-functions/v2";
// import { getStorage } from "firebase-admin/storage";

// setGlobalOptions({ region: "southamerica-east1", memory: "512MiB" });
// import { initializeApp } from 'firebase-admin/app';
// initializeApp();

// // *** IMPORTANT: Set up jsdom and the canvas BEFORE importing png2svg ***
// console.log('Before require("canvas")');
// import { createCanvas } from 'canvas'; // Use require here
// console.log('After require("canvas")');

// console.log('Before require("jsdom")');
// import * as jsdom from 'jsdom'; // Use require here
// const { JSDOM } = jsdom;

// console.log('After require("jsdom")');

// const resourceLoader = new jsdom.ResourceLoader({
//     userAgent: 'node.js', // Or a more descriptive user agent
//   });

// console.log('Before JSDOM constructor');
// const dom = new JSDOM(`<!DOCTYPE html><html><body></body></html>`, {
//     canvas: {
//         createCanvas: () => {
//             console.log('Creating canvas...');
//             try {
//                 const canvas = createCanvas(1, 1); // No arguments.  Just test.
//                 console.log('Canvas created successfully.');
//                 return canvas;
//             } catch (canvasError) {
//                 console.error('Error creating canvas:', canvasError);
//                 return null; // Or throw the error, depending on how you want to handle it
//             }
//         },
//     },
//     resources: resourceLoader, 
// });
// console.log('After JSDOM constructor');

// global.window = dom.window;
// global.document = dom.window.document;
// global.Image = dom.window.Image;  // Provide the Image constructor

// import sharp from 'sharp';  // Import Sharp
// // import { png2svg } from 'svg-png-converter';
// import * as fs from 'fs/promises';
// console.log('Before require("imagetracerjs")');

// import imagetracerjs from 'imagetracerjs'; // Assuming 'trace' is the core vectorization function from bitmap2vector
// console.log('After require("imagetracerjs")');


// async function convertImageToSvg(inputPath, outputPath) {
//     try {

//       // 1. Resize the image using Sharp
//       let sharpImage = sharp(inputPath); // Load the image

//       // Get the original image dimensions
//       const metadata = await sharpImage.metadata();
//       const originalWidth = metadata.width;
//       const originalHeight = metadata.height;

//       // Calculate the new dimensions while preserving aspect ratio
//       let newWidth = originalWidth;
//       let newHeight = originalHeight;

//       if (originalWidth > 200 || originalHeight > 200) {
//           if (originalWidth > originalHeight) {
//               newWidth = 200;
//               newHeight = Math.round((originalHeight / originalWidth) * 200);
//           } else {
//               newHeight = 200;
//               newWidth = Math.round((originalWidth / originalHeight) * 200);
//           }
//       }

//       // Resize the image
//       sharpImage = sharpImage.resize(newWidth, newHeight, {
//           fit: sharp.fit.inside, // Ensures aspect ratio is preserved
//           withoutEnlargement: true, // Prevents upscaling if image is smaller than 200x200
//       });

//       // 2. Convert the image to ImageData object (required by ImageTracer)
//       const buffer = await sharpImage.raw().toBuffer();
//       const imageData = {
//           width: newWidth,
//           height: newHeight,
//           data: buffer, // The raw pixel data
//       };
//       // const result = await png2svg({
//       //   width: info.width,
//       //       height: info.height,
//       //     input: data,
//       //     tracer: 'bitmap2vector',
//       //     optimize: true,
//       //     numberofcolors: 64,
//       //     pathomit: 1,
//       // });

//        // 3. Trace to SVG using ImageTracer.imagedataToSVG()
//        console.log('Before ImageTracer.imagedataToSVG');
//        const svgString = imagetracerjs.imagedataToSVG(imageData, {
			
//         // Tracing
//         corsenabled : false,
//         ltres : 0,
//         qtres : 0,
//         pathomit : 0,
//         rightangleenhance : true,
        
//         // Color quantization
//         colorsampling : 0,
//         numberofcolors : 256,
//         mincolorratio : 0,
//         colorquantcycles : 3,
        
//         // Layering method
//         layering : 0,
        
//         // SVG rendering
//         strokewidth : 1,
//         linefilter : false,
//         scale : 2,
//         roundcoords : 2,
//         viewbox : false,
//         desc : false,
//         lcpr : 0,
//         qcpr : 0,
        
//         // Blur
//         blurradius : 0,
//         blurdelta : 20
        
//       },);
//        console.log('After ImageTracer.imagedataToSVG');
  
//       await fs.writeFile(outputPath, svgString);
//       console.log(`Successfully converted ${inputPath} to ${outputPath}`);
//     } catch (error) {
//       console.error(`Error converting ${inputPath}:`, error);
//       throw error; // Re-throw the error to signal failure
//     }
//   }
  
//   export const onUserDocumentUpdate = onDocumentUpdated("adm_products/{documentId}", async (change) => {
//     const bucket = getStorage().bucket();
//     const oldStatus = change.data.before.data().status;
//     const newStatus = change.data.after.data().status;
//     const documentId = change.data.after.data().documentId;
//     const filePath = `adm_products/${documentId}`; // Construct the full file path
  
//     if (oldStatus === 1 && newStatus === 2) {
//       try {
//         const file = bucket.file(filePath);
//         const [exists] = await file.exists(); // Check if the file exists
  
//         if (!exists) {
//           console.log(`File ${filePath} does not exist.  Skipping conversion.`);
//           return null; // Exit the function gracefully
//         }
  
//         const tmpPngFilePath = `/tmp/${documentId}.png`; // Use .png extension
//         const tmpSvgFilePath = `/tmp/${documentId}.svg`;
  
//         // Download the file
//         await file.download({ destination: tmpPngFilePath });
//         console.log(`File ${filePath} downloaded to ${tmpPngFilePath}`);

//         // **Add these lines**
//         const fileStats = await fs.stat(tmpPngFilePath);
//         console.log(`File size: ${fileStats.size} bytes`);

//         if (fileStats.size === 0) {
//             console.error('Downloaded file is empty!');
//             return null; // Or throw an error
//         }
  
//         // Convert the image to SVG
//         await convertImageToSvg(tmpPngFilePath, tmpSvgFilePath);
  
//         console.log(`Successfully converted ${tmpPngFilePath} to ${tmpSvgFilePath}`);
  
//         // TODO: Upload the SVG file back to Firebase Storage (optional)
//         // For example:
//         await bucket.upload(tmpSvgFilePath, { destination: `adm_svg_products/${documentId}.svg` });
//         console.log(`SVG file uploaded to Firebase Storage.`);
  
//         // Clean up temporary files (important!)
//         await fs.unlink(tmpPngFilePath);
//         await fs.unlink(tmpSvgFilePath);
//         console.log('Temporary files cleaned up.');
  
//         return null; //  Return null or Promise.resolve() for Cloud Functions
//       } catch (error) {
//         console.error('Error during processing:', error);
//         // Handle the error appropriately (e.g., update Firestore, send a notification)
//         return null; // Indicate that the function failed
//       }
//     } else {
//       console.log('Nothing changed...');
//       return null; // or Promise.resolve()
//     }
//   });