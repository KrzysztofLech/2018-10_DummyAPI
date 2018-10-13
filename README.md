# 'Espeo Software' Recruitment Task
October 2018  
<br> 

## Task description:

Your task is to build a simple iOS application that displays data from a dummy JSON REST API.
The app is a simple document browser. It should list available documents split into categories showing thumbnails and titles. It should allow switching from the list to a detailed view of a document that displays all the information about it.

Keep in mind to design project architecture as easy to maintain and develop in the future. Consider adding couple tests to your project.
The user experience and design are up to you. However, we would like the overall effect to be intuitive, visually attractive and tidy. Please take care of content presentation.

Documents are described by the attributes:

* id
* title
* category name
* thumbnailImg
* headerImg
* author
* created date (given in UTC time)
* text (document content, split into paragraphs using HTML `<p>` tags)


The list of available documents can be found at `GET /api/v1/documents`. The data describing documents on the listing is not full. Some attributes are available only when the document details are accessed at `GET /api/v1/documents/{documentId}`.

## API:

The API project can be found in the attachement (`dummy-api-server.zip`).<br>
Description on how to run the server can be found in the README.md file.