/**
 * Created by ridel1e on 17/09/16.
 */
import fs from 'fs';
export default function(filePath) {
    return new Promise((resolve, reject) => {
        fs.readFile(filePath, (err, data) => {
            if (err) {
                reject(err)
            }
            resolve(data)
        })
    })
}