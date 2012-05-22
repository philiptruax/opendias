BEGIN TRANSACTION;
INSERT INTO docs (docid, doneocr, ocrtext, depth, lines, ppl, resolution, docdatey, docdatem, docdated, entrydate, filetype, title, pages, actionrequired, hardcopyKept) VALUES (1,1,'This is the OCR text.',8,3509,2519,300,2010,12,31,'2011-01-02T21:13:04.393946Z',2,'Test Titletext',1,0,1);
INSERT INTO docs (docid, doneocr, ocrtext, depth, lines, ppl, resolution, docdatey, docdatem, docdated, entrydate, filetype, title, pages, actionrequired, hardcopyKept) VALUES (4,1,'This is OCR text 4.',8,3509,2519,300,2010,12,30,'2011-01-03T21:13:04.393946Z',4,'Test 1 TitleText 2',1,0,1);
INSERT INTO docs (docid, doneocr, ocrtext, depth, lines, ppl, resolution, docdatey, docdatem, docdated, entrydate, filetype, title, pages, actionrequired, hardcopyKept) VALUES (3,1,'This is OCR text 2.',8,3509,2519,300,2011,01,01,'2011-01-04T21:13:04.393946Z',2,'Test 2 Title text',1,1,1);
INSERT INTO docs (docid, doneocr, ocrtext, depth, lines, ppl, resolution, docdatey, docdatem, docdated, entrydate, filetype, title, pages, actionrequired, hardcopyKept) VALUES (2,1,'This is final OCR text 3.',8,3509,2519,300,2012,12,31,'2011-01-04T21:13:05.393946Z',3,'Test 3 Title',1,1,1);
INSERT INTO tags (tagid, tagname) VALUES (31, 'tag one');
INSERT INTO tags (tagid, tagname) VALUES (32, 'tag two');
INSERT INTO tags (tagid, tagname) VALUES (33, 'tag three');
INSERT INTO doc_tags (doctagid, docid, tagid) VALUES (1, 2, 31);
INSERT INTO doc_tags (doctagid, docid, tagid) VALUES (2, 2, 32);
INSERT INTO doc_tags (doctagid, docid, tagid) VALUES (3, 3, 32);
INSERT INTO doc_tags (doctagid, docid, tagid) VALUES (4, 4, 33);
COMMIT;
