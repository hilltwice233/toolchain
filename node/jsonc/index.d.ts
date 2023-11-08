declare function removeJsonComments(raw: string): string;
declare function parseJsonc(raw: string): any;
declare function parseJsoncFile(path: string): any;

export { parseJsonc, parseJsoncFile, removeJsonComments };
