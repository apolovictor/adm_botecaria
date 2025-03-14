// import { onDocumentUpdated} from "firebase-functions/v2/firestore";
// import { setGlobalOptions } from "firebase-functions/v2";
// import { getStorage } from "firebase-admin/storage";

// setGlobalOptions({ region: "southamerica-east1" });
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


// // import { png2svg } from 'svg-png-converter';
// import sharp from 'sharp';  // Import Sharp
// import bitmap2vector from 'bitmap2vector'; // Import trace from bitmap2vector
// // const trace = bitmap2vector.trace;

// import * as fs from 'fs/promises';



// // async function convertImageToSvg(inputPath, outputPath) {
// //     try {
// //       const result = await png2svg({
// //         input: inputPath,
// //         tracer: 'bitmap2vector',
// //         optimize: true,
// //         numberofcolors: 16,
// //         pathomit: 1,
// //       });
  
// //       await fs.writeFile(outputPath, result.content);
// //       console.log(`Successfully converted ${inputPath} to ${outputPath}`);
// //     } catch (error) {
// //       console.error(`Error converting ${inputPath}:`, error);
// //       throw error; // Re-throw the error to signal failure
// //     }
// //   }

// async function convertImageToSvg(inputPath, outputPath) {
//     try {
//         // 1. Use Sharp to process the image
//         const image = await sharp(inputPath);

//         // 2. Convert the image to a raw pixel buffer (RGBA format)
//         const { data, info } = await image
//             .raw()
//             .toBuffer({ resolveWithObject: true });

//         // 3. Vectorize using bitmap2vector (trace)
//         // const result = trace({
//         //     width: info.width,
//         //     height: info.height,
//         //     imageData: data, // Pass the raw pixel data
//         //     tracer: 'bitmap2vector', // Other bitmap2vector options
//         //     optimize: true,
//         //     numberofcolors: 16,
//         //     pathomit: 1,
//         // });

//         const out = await bitmap2vector({
//             input: readFileSync(inputPath)
//           });

//         await fs.writeFile(outputPath, data);

//         //   writeFileSync(outputPath, out.content)
           

//         // 4. Write the SVG to a file
//         // await fs.writeFile(outputPath, result, 'utf-8');
//         console.log(`Successfully converted ${inputPath} to ${outputPath}`);
//     } catch (error) {
//         console.error(`Error converting ${inputPath}:`, error);
//         throw error; // Re-throw the error to signal failure
//     }
// }
  
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


//   // export const onUserDocumentUpdate = onDocumentUpdated("adm_products/{documentId}", (change) => {
// //     const bucket = getStorage().bucket();
// //     const oldStatus = change.data.before.data().status;
// //     const newStatus = change.data.after.data().status;
// //     const documentId = change.data.after.data().documentId;
// //     const filePath = `adm_products/${documentId}`; // Construct the full file path


// //     if(oldStatus == 1 && newStatus == 2){

// //         const file = bucket.file(filePath);

// //         console.log(file.exists());
// //         console.log(file.name);
// //     } else {
// //         console.log('Nothing changed...');
// //     }

// //     return Promise.resolve();
// // })