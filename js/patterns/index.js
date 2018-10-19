import { object, increment } from './singleton';

import transform from './step';

console.log(object.counter);

transform();

console.log(object.counter);

