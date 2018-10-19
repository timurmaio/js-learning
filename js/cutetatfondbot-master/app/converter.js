/**
 * Created by ridel1e on 17/09/16.
 */
import fs from 'fs';
import CloudConvert from 'cloudconvert';

const cconvert = new CloudConvert('VKGJgsavETl8Xrqw4zZCqQdLgbAoAQ1wyjv3RiHO11avJJJ0aqKZG725-La57iqG1jvBaHSGDnk6WzHoXhDuww');

export default (filePath) => {
    const outputFileName = filePath.substring(0, filePath.lastIndexOf('.') + 1) + "wav";
    return new Promise((resolve, reject) => {
        fs.createReadStream(filePath).pipe(cconvert.convert({
            "inputformat": "oga",
            "outputformat": "wav",
            "input": "upload"
        })).pipe(fs.createWriteStream(outputFileName)).on('finish', () => resolve(outputFileName));
    });
};