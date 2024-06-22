## Introduction
[OpenAI](https://openai.com/) is an AI research and deployment company. **Xojo-OpenAI** is a Xojo and RealStudio wrapper for the OpenAI public API.

## Example
This example chats with an AI assistant. [**More examples**](https://github.com/charonn0/Xojo-OpenAI/wiki#examples).
```realbasic
  OpenAI.APIKey = "YOUR KEY HERE"
  Dim reply As OpenAI.ChatCompletion = OpenAI.ChatCompletion.Create("user", "Hello, I've come here looking for an argument.")
  Dim chatresult As String = reply.GetResult() ' assistant: No you haven't!
  
  reply = reply.GenerateNext("user", "Yes I have!")
  chatresult = reply.GetResult() ' assistant: Sorry, is this the 5 minute argument, or the whole half hour?
  
  reply = reply.GenerateNext("user", "What?")
  chatresult = reply.GetResult() ' assistant: Are you here for the whole half hour?
  
  'etc.
```

## Highlights
* Issue natural-language instructions to the AI
* Generate images based on a description
* Translate and transcribe digital audio
* Speech synthesis
* Analyze text for hate, threats, self-harm, sexual content, child abuse, and violence
* Can use the [RB-libcURL](https://github.com/charonn0/RB-libcURL) wrapper, the [MonkeyBread curl plugin](https://www.monkeybreadsoftware.net/class-curlmbs.shtml), the Xojo URLConnection, or the Xojo HTTPSecureSocket to make API requests. 

![XojoOpenAI1](https://github.com/charonn0/Xojo-OpenAI/assets/585485/b01f8eda-66e9-4ba1-8cad-120b67ab8c15)

_This screen shot depicts the Xojo-OpenAI demo showing the result of an image generation request._

## Become a sponsor
If you use this code in a commercial project, or just want to show your appreciation, please consider sponsoring me through GitHub. https://github.com/sponsors/charonn0

## Synopsis

OpenAI API endpoints are exposed through several object classes:

|Endpoint|Object Class|Comment|
|-----------|------------|-------|
|[`/v1/chat/completions`](https://platform.openai.com/docs/api-reference/chat/create)|[`ChatCompletion`](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ChatCompletion)|An AI response to a chat conversation prompt.| 
|`/v1/chat/completions`|[`ImageRecognition`](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ImageRecognition)|An AI response to a chat-based image recognition session.| 
|[`/v1/images/generations`](https://platform.openai.com/docs/api-reference/images/create) and [`/v1/images/edits`](https://platform.openai.com/docs/api-reference/images/createEdit)|[`Image`](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Image)|An image that was generated or modified.| 
|[`/v1/audio/speech`](https://platform.openai.com/docs/api-reference/audio)|[`AudioGeneration`](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Audiogeneration)|A digital audio file containing synthesized speech from provided text.|
|[`/v1/audio/transcriptions`](https://platform.openai.com/docs/api-reference/audio/createTranscription)|[`AudioTranscription`](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.AudioTranscription)|A transcript of an English language audio file.| 
|[`/v1/audio/translations`](https://platform.openai.com/docs/api-reference/audio/createTranslation)|[`AudioTranslation`](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.AudioTranslation)|An English translation of an audio file.| 
|[`/v1/moderations`](https://platform.openai.com/docs/api-reference/moderations)|[`Moderation`](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Moderation)|An analysis of offensive content in a given text. (i.e. "content moderation")| 
|[`/v1/models`](https://platform.openai.com/docs/api-reference/models)|[`Model`](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Model)|List and select from the available AI models|
|[`/v1/files`](https://platform.openai.com/docs/api-reference/files)|[`File`](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File)|A fine-tuning file that has been, is being, or will be uploaded.|

To make a request of the API, call the appropriate factory method on the corresponding object class. For example, to make a request of the `/v1/images/generations` endpoint you would use the [OpenAI.Image.Create](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Image.Create) factory method, whereas the `/v1/images/edits` endpoint is accessed using the [OpenAI.Image.Edit](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Image.Edit) factory method. Factory methods perform the request and return a [OpenAI.Response](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response) object (or one of its subclasses) containing the response.

Responses may have zero, one, or several choices, depending on the number of results you asked for. You can see how many choices are available by reading the [Response.ResultCount](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.ResultCount) property, and retrieve each result by calling the [Response.GetResult](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.GetResult) method.

Factory methods generally come in two flavors: basic and advanced. The basic versions accept a few common parameters as direct arguments while the advanced versions accept a [OpenAI.Request](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Request) object with the correct properties set. 

```realbasic
  OpenAI.APIKey = "YOUR API KEY"
  Dim chatlog As New OpenAI.ChatCompletionData
  chatlog.AddMessage("user", "What is the airspeed velocity of an unladen European swallow?")
  Dim request As New OpenAI.Request
  request.Model = "gpt-4"
  request.Messages = chatlog
  Dim result As OpenAI.Response = OpenAI.ChatCompletion.Create(request)
  Dim answer As String = result.GetResult()
```

## How to incorporate OpenAI into your Xojo project

### Copy the OpenAI module
1. Download the Xojo-OpenAI project either in [ZIP archive format](https://github.com/charonn0/Xojo-OpenAI/archive/master.zip) or by cloning the repository with your Git client.
2. Open the Xojo-OpenAI project in REALstudio or Xojo. Open your project in a separate window.
3. Copy the Xojo-OpenAI module into your project and save. _**Do not use the "Import" feature of the Xojo IDE.**_

### Using RB-libcURL or MBS
The OpenAI module may optionally use my open source [RB-libcURL](https://github.com/charonn0/RB-libcURL) wrapper or the commercial MBS libcurl plugin. These should be preferred in order to take advantage of HTTP/2. If neither of these are available, the built-in `URLConnection` class is used if it is available. In versions of Xojo that do not have the URLConnection class (<=2018r2) the built-in `HTTPSecureSocket` class is used unless it's too old (<=2014r2), in which case you will need to use one of the curl options.

To enable RB-libcURL, copy (not Import) the `libcURL` module from the RB-libcURL project into your project and set the `OpenAI.USE_RBLIBCURL` constant to `True`.

To enable the MBS plugin, ensure the plugin is installed and then set `OpenAI.USE_MBS` constant to `True`.

If both `USE_RBLIBCURL` and `USE_MBS` are `True` then `USE_RBLIBCURL` takes precedence.

If you are using neither RB-libcURL nor MBS then set both `USE_RBLIBCURL` and `USE_MBS` to `False` to avoid compiler errors.

## [Examples](https://github.com/charonn0/Xojo-OpenAI/wiki/Examples)
  * Text
    * [Chat with an AI assistant](https://github.com/charonn0/Xojo-OpenAI/wiki/Examples#chatting-with-an-ai-assistant)
    * [Translate text](https://github.com/charonn0/Xojo-OpenAI/wiki/Examples#translate-text)
    * [Detect offensive content](https://github.com/charonn0/Xojo-OpenAI/wiki/Examples#check-text-for-offensive-content)
  * Images
    * [Computer vision](https://github.com/charonn0/Xojo-OpenAI/wiki/Examples#computer-vision)
    * [Generate picture](https://github.com/charonn0/Xojo-OpenAI/wiki/Examples#generate-picture)
    * [Edit picture](https://github.com/charonn0/Xojo-OpenAI/wiki/Examples#edit-a-picture)
  * Audio
    * [Translate audio](https://github.com/charonn0/Xojo-OpenAI/wiki/Examples#translate-audio)
    * [Generate subtitles](https://github.com/charonn0/Xojo-OpenAI/wiki/Examples#generate-subtitles-for-a-video)
    * [Speech synthesis](https://github.com/charonn0/Xojo-OpenAI/wiki/Examples#speech-synthesis)
  * [Sending custom requests](https://github.com/charonn0/Xojo-OpenAI/wiki/Examples#sending-a-custom-request)
  * [Training custom AI models](https://github.com/charonn0/Xojo-OpenAI/wiki/Examples#training-a-fine-tuned-ai-model)
