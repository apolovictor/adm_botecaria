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
// import { png2svg } from 'svg-png-converter';
// import * as fs from 'fs/promises';



// async function convertImageToSvg(inputPath, outputPath) {
//     try {

//       // 1. Resize the image using Sharp
//       let sharpImage = sharp(inputPath); // Load the image

//       // Get the original image dimensions
//       const metadata = await sharpImage.metadata();
//       const originalWidth = metadata.width;
//       const originalHeight = metadata.height;

//       console.log('size: ', metadata.size);

//      // 2. Convert the image to a raw pixel buffer (RGBA format)
//       const { data } = await sharpImage        
//         .toBuffer({ resolveWithObject: true });
//       const result = await png2svg({
//           width: originalWidth,
//           height: originalHeight,
//           input: data,
//           tracer: 'bitmap2vector',
//           optimize: true,
//           numberofcolors: (originalWidth > 1000 || originalHeight > 1000 ) ? 64 : 24,
//           pathomit: 8,
//       });
  
//       await fs.writeFile(outputPath, result.content);
//       console.log(`Successfully converted ${inputPath} to ${outputPath}`);
//     } catch (error) {
//       console.error(`Error converting ${inputPath}:`, error);
//       throw error; // Re-throw the error to signal failure
//     }
//   }
  
//   export const onUserDocumentUpdate = onDocumentUpdated("adm_products/{documentId}", async (change) => {
//     const bucket = getStorage().bucket();
//     const newStatus = change.data.after.data().status;
//     const documentId = change.data.after.data().documentId;
//     const filePath = `adm_products/${documentId}`; // Construct the full file path
  
//     if (newStatus === 2) {
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
//         await bucket.upload(tmpSvgFilePath, { destination: `adm_svg_products/${documentId}` });
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