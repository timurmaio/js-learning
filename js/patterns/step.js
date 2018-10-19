import { object, increment } from './singleton';

export default function transform() {
    increment();
    object.name = 'Bulat'
}