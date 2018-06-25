package deng.fzip
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   [Event(name="fileLoaded",type="deng.fzip.FZipEvent")]
   [Event(name="parseError",type="deng.fzip.FZipErrorEvent")]
   [Event(name="complete",type="flash.events.Event")]
   [Event(name="httpStatus",type="flash.events.HTTPStatusEvent")]
   [Event(name="ioError",type="flash.events.IOErrorEvent")]
   [Event(name="open",type="flash.events.Event")]
   [Event(name="progress",type="flash.events.ProgressEvent")]
   [Event(name="securityError",type="flash.events.SecurityErrorEvent")]
   public class FZip extends EventDispatcher
   {
      
      static const SIG_CENTRAL_FILE_HEADER:uint = 33639248;
      
      static const SIG_SPANNING_MARKER:uint = 808471376;
      
      static const SIG_LOCAL_FILE_HEADER:uint = 67324752;
      
      static const SIG_DIGITAL_SIGNATURE:uint = 84233040;
      
      static const SIG_END_OF_CENTRAL_DIRECTORY:uint = 101010256;
      
      static const SIG_ZIP64_END_OF_CENTRAL_DIRECTORY:uint = 101075792;
      
      static const SIG_ZIP64_END_OF_CENTRAL_DIRECTORY_LOCATOR:uint = 117853008;
      
      static const SIG_DATA_DESCRIPTOR:uint = 134695760;
      
      static const SIG_ARCHIVE_EXTRA_DATA:uint = 134630224;
      
      static const SIG_SPANNING:uint = 134695760;
       
      
      protected var filesList:Array;
      
      protected var filesDict:Dictionary;
      
      protected var urlStream:URLStream;
      
      protected var charEncoding:String;
      
      protected var parseFunc:Function;
      
      protected var currentFile:FZipFile;
      
      protected var ddBuffer:ByteArray;
      
      protected var ddSignature:uint;
      
      protected var ddCompressedSize:uint;
      
      public function FZip(filenameEncoding:String = "utf-8")
      {
         super();
         charEncoding = filenameEncoding;
         parseFunc = parseIdle;
      }
      
      public function get active() : Boolean
      {
         return parseFunc !== parseIdle;
      }
      
      public function load(request:URLRequest) : void
      {
         if(!urlStream && parseFunc == parseIdle)
         {
            urlStream = new URLStream();
            urlStream.endian = "littleEndian";
            addEventHandlers();
            filesList = [];
            filesDict = new Dictionary();
            parseFunc = parseSignature;
            urlStream.load(request);
         }
      }
      
      public function loadBytes(bytes:ByteArray) : void
      {
         if(!urlStream && parseFunc == parseIdle)
         {
            filesList = [];
            filesDict = new Dictionary();
            bytes.position = 0;
            bytes.endian = "littleEndian";
            parseFunc = parseSignature;
            if(parse(bytes))
            {
               parseFunc = parseIdle;
               dispatchEvent(new Event("complete"));
            }
            else
            {
               dispatchEvent(new FZipErrorEvent("parseError","EOF"));
            }
         }
      }
      
      public function close() : void
      {
         if(urlStream)
         {
            parseFunc = parseIdle;
            removeEventHandlers();
            urlStream.close();
            urlStream = null;
         }
      }
      
      public function serialize(stream:IDataOutput, includeAdler32:Boolean = false) : void
      {
         var endian:* = null;
         var ba:* = null;
         var offset:* = 0;
         var files:* = 0;
         var i:int = 0;
         var file:* = null;
         if(stream != null && filesList.length > 0)
         {
            endian = stream.endian;
            ba = new ByteArray();
            var _loc9_:String = "littleEndian";
            ba.endian = _loc9_;
            stream.endian = _loc9_;
            offset = uint(0);
            files = uint(0);
            for(i = 0; i < filesList.length; )
            {
               file = filesList[i] as FZipFile;
               if(file != null)
               {
                  file.serialize(ba,includeAdler32,true,offset);
                  offset = uint(offset + file.serialize(stream,includeAdler32));
                  files++;
               }
               i++;
            }
            if(ba.length > 0)
            {
               stream.writeBytes(ba);
            }
            stream.writeUnsignedInt(101010256);
            stream.writeShort(0);
            stream.writeShort(0);
            stream.writeShort(files);
            stream.writeShort(files);
            stream.writeUnsignedInt(ba.length);
            stream.writeUnsignedInt(offset);
            stream.writeShort(0);
            stream.endian = endian;
         }
      }
      
      public function getFileCount() : uint
      {
         return !!filesList?filesList.length:0;
      }
      
      public function getFileAt(index:uint) : FZipFile
      {
         return !!filesList?filesList[index] as FZipFile:null;
      }
      
      public function getFileByName(name:String) : FZipFile
      {
         return !!filesDict[name]?filesDict[name] as FZipFile:null;
      }
      
      public function addFile(name:String, content:ByteArray = null, doCompress:Boolean = true) : FZipFile
      {
         return addFileAt(!!filesList?filesList.length:0,name,content,doCompress);
      }
      
      public function addFileFromString(name:String, content:String, charset:String = "utf-8", doCompress:Boolean = true) : FZipFile
      {
         return addFileFromStringAt(!!filesList?filesList.length:0,name,content,charset,doCompress);
      }
      
      public function addFileAt(index:uint, name:String, content:ByteArray = null, doCompress:Boolean = true) : FZipFile
      {
         if(filesList == null)
         {
            filesList = [];
         }
         if(filesDict == null)
         {
            filesDict = new Dictionary();
         }
         else if(filesDict[name])
         {
            throw new Error("File already exists: " + name + ". Please remove first.");
         }
         var file:FZipFile = new FZipFile();
         file.filename = name;
         file.setContent(content,doCompress);
         if(index >= filesList.length)
         {
            filesList.push(file);
         }
         else
         {
            filesList.splice(index,0,file);
         }
         filesDict[name] = file;
         return file;
      }
      
      public function addFileFromStringAt(index:uint, name:String, content:String, charset:String = "utf-8", doCompress:Boolean = true) : FZipFile
      {
         if(filesList == null)
         {
            filesList = [];
         }
         if(filesDict == null)
         {
            filesDict = new Dictionary();
         }
         else if(filesDict[name])
         {
            throw new Error("File already exists: " + name + ". Please remove first.");
         }
         var file:FZipFile = new FZipFile();
         file.filename = name;
         file.setContentAsString(content,charset,doCompress);
         if(index >= filesList.length)
         {
            filesList.push(file);
         }
         else
         {
            filesList.splice(index,0,file);
         }
         filesDict[name] = file;
         return file;
      }
      
      public function removeFileAt(index:uint) : FZipFile
      {
         var file:* = null;
         if(filesList != null && filesDict != null && index < filesList.length)
         {
            file = filesList[index] as FZipFile;
            if(file != null)
            {
               filesList.splice(index,1);
               delete filesDict[file.filename];
               return file;
            }
         }
         return null;
      }
      
      protected function parse(stream:IDataInput) : Boolean
      {
         while(parseFunc(stream))
         {
         }
         return parseFunc === parseIdle;
      }
      
      protected function parseIdle(stream:IDataInput) : Boolean
      {
         return false;
      }
      
      protected function parseSignature(stream:IDataInput) : Boolean
      {
         var sig:* = 0;
         if(stream.bytesAvailable >= 4)
         {
            sig = uint(stream.readUnsignedInt());
            var _loc3_:* = sig;
            if(67324752 !== _loc3_)
            {
               if(33639248 !== _loc3_)
               {
                  if(101010256 !== _loc3_)
                  {
                     if(808471376 !== _loc3_)
                     {
                        if(84233040 !== _loc3_)
                        {
                           if(101075792 !== _loc3_)
                           {
                              if(117853008 !== _loc3_)
                              {
                                 if(134695760 !== _loc3_)
                                 {
                                    if(134630224 !== _loc3_)
                                    {
                                       if(134695760 !== _loc3_)
                                       {
                                          throw new Error("Unknown record signature: 0x" + sig.toString(16));
                                       }
                                    }
                                    addr43:
                                    parseFunc = parseIdle;
                                 }
                                 addr42:
                                 §§goto(addr43);
                              }
                              addr41:
                              §§goto(addr42);
                           }
                           addr40:
                           §§goto(addr41);
                        }
                        addr39:
                        §§goto(addr40);
                     }
                     addr38:
                     §§goto(addr39);
                  }
                  addr37:
                  §§goto(addr38);
               }
               §§goto(addr37);
            }
            else
            {
               parseFunc = parseLocalfile;
               currentFile = new FZipFile(charEncoding);
            }
            return true;
         }
         return false;
      }
      
      protected function parseLocalfile(stream:IDataInput) : Boolean
      {
         if(currentFile.parse(stream))
         {
            if(currentFile.hasDataDescriptor)
            {
               parseFunc = findDataDescriptor;
               ddBuffer = new ByteArray();
               ddSignature = 0;
               ddCompressedSize = 0;
               return true;
            }
            onFileLoaded();
            if(parseFunc != parseIdle)
            {
               parseFunc = parseSignature;
               return true;
            }
         }
         return false;
      }
      
      protected function findDataDescriptor(stream:IDataInput) : Boolean
      {
         var c:* = 0;
         while(stream.bytesAvailable > 0)
         {
            c = uint(stream.readUnsignedByte());
            ddSignature = ddSignature >>> 8 | c << 24;
            if(ddSignature == 134695760)
            {
               ddBuffer.length = ddBuffer.length - 3;
               parseFunc = validateDataDescriptor;
               return true;
            }
            ddBuffer.writeByte(c);
         }
         return false;
      }
      
      protected function validateDataDescriptor(stream:IDataInput) : Boolean
      {
         var ddCRC32:* = 0;
         var ddSizeCompressed:* = 0;
         var ddSizeUncompressed:* = 0;
         if(stream.bytesAvailable >= 12)
         {
            ddCRC32 = uint(stream.readUnsignedInt());
            ddSizeCompressed = uint(stream.readUnsignedInt());
            ddSizeUncompressed = uint(stream.readUnsignedInt());
            if(ddBuffer.length == ddSizeCompressed)
            {
               ddBuffer.position = 0;
               currentFile._crc32 = ddCRC32;
               currentFile._sizeCompressed = ddSizeCompressed;
               currentFile._sizeUncompressed = ddSizeUncompressed;
               currentFile.parseContent(ddBuffer);
               onFileLoaded();
               parseFunc = parseSignature;
            }
            else
            {
               ddBuffer.writeUnsignedInt(ddCRC32);
               ddBuffer.writeUnsignedInt(ddSizeCompressed);
               ddBuffer.writeUnsignedInt(ddSizeUncompressed);
               parseFunc = findDataDescriptor;
            }
            return true;
         }
         return false;
      }
      
      protected function onFileLoaded() : void
      {
         filesList.push(currentFile);
         if(currentFile.filename)
         {
            filesDict[currentFile.filename] = currentFile;
         }
         dispatchEvent(new FZipEvent("fileLoaded",currentFile));
         currentFile = null;
      }
      
      protected function progressHandler(evt:Event) : void
      {
         dispatchEvent(evt.clone());
         try
         {
            if(parse(urlStream))
            {
               close();
               dispatchEvent(new Event("complete"));
            }
            return;
         }
         catch(e:Error)
         {
            close();
            if(hasEventListener("parseError"))
            {
               dispatchEvent(new FZipErrorEvent("parseError",e.message));
            }
            else
            {
               throw e;
            }
            return;
         }
      }
      
      protected function defaultHandler(evt:Event) : void
      {
         dispatchEvent(evt.clone());
      }
      
      protected function defaultErrorHandler(evt:Event) : void
      {
         close();
         dispatchEvent(evt.clone());
      }
      
      protected function addEventHandlers() : void
      {
         urlStream.addEventListener("complete",defaultHandler);
         urlStream.addEventListener("open",defaultHandler);
         urlStream.addEventListener("httpStatus",defaultHandler);
         urlStream.addEventListener("ioError",defaultErrorHandler);
         urlStream.addEventListener("securityError",defaultErrorHandler);
         urlStream.addEventListener("progress",progressHandler);
      }
      
      protected function removeEventHandlers() : void
      {
         urlStream.removeEventListener("complete",defaultHandler);
         urlStream.removeEventListener("open",defaultHandler);
         urlStream.removeEventListener("httpStatus",defaultHandler);
         urlStream.removeEventListener("ioError",defaultErrorHandler);
         urlStream.removeEventListener("securityError",defaultErrorHandler);
         urlStream.removeEventListener("progress",progressHandler);
      }
   }
}
