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
      
      public function FZip(param1:String = "utf-8")
      {
         super();
         charEncoding = param1;
         parseFunc = parseIdle;
      }
      
      public function get active() : Boolean
      {
         return parseFunc !== parseIdle;
      }
      
      public function load(param1:URLRequest) : void
      {
         if(!urlStream && parseFunc == parseIdle)
         {
            urlStream = new URLStream();
            urlStream.endian = "littleEndian";
            addEventHandlers();
            filesList = [];
            filesDict = new Dictionary();
            parseFunc = parseSignature;
            urlStream.load(param1);
         }
      }
      
      public function loadBytes(param1:ByteArray) : void
      {
         if(!urlStream && parseFunc == parseIdle)
         {
            filesList = [];
            filesDict = new Dictionary();
            param1.position = 0;
            param1.endian = "littleEndian";
            parseFunc = parseSignature;
            if(parse(param1))
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
      
      public function serialize(param1:IDataOutput, param2:Boolean = false) : void
      {
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc7_:* = 0;
         var _loc3_:* = 0;
         var _loc8_:int = 0;
         var _loc6_:* = null;
         if(param1 != null && filesList.length > 0)
         {
            _loc5_ = param1.endian;
            _loc4_ = new ByteArray();
            var _loc9_:String = "littleEndian";
            _loc4_.endian = _loc9_;
            param1.endian = _loc9_;
            _loc7_ = uint(0);
            _loc3_ = uint(0);
            _loc8_ = 0;
            while(_loc8_ < filesList.length)
            {
               _loc6_ = filesList[_loc8_] as FZipFile;
               if(_loc6_ != null)
               {
                  _loc6_.serialize(_loc4_,param2,true,_loc7_);
                  _loc7_ = uint(_loc7_ + _loc6_.serialize(param1,param2));
                  _loc3_++;
               }
               _loc8_++;
            }
            if(_loc4_.length > 0)
            {
               param1.writeBytes(_loc4_);
            }
            param1.writeUnsignedInt(101010256);
            param1.writeShort(0);
            param1.writeShort(0);
            param1.writeShort(_loc3_);
            param1.writeShort(_loc3_);
            param1.writeUnsignedInt(_loc4_.length);
            param1.writeUnsignedInt(_loc7_);
            param1.writeShort(0);
            param1.endian = _loc5_;
         }
      }
      
      public function getFileCount() : uint
      {
         return !!filesList?filesList.length:0;
      }
      
      public function getFileAt(param1:uint) : FZipFile
      {
         return !!filesList?filesList[param1] as FZipFile:null;
      }
      
      public function getFileByName(param1:String) : FZipFile
      {
         return !!filesDict[param1]?filesDict[param1] as FZipFile:null;
      }
      
      public function addFile(param1:String, param2:ByteArray = null, param3:Boolean = true) : FZipFile
      {
         return addFileAt(!!filesList?filesList.length:0,param1,param2,param3);
      }
      
      public function addFileFromString(param1:String, param2:String, param3:String = "utf-8", param4:Boolean = true) : FZipFile
      {
         return addFileFromStringAt(!!filesList?filesList.length:0,param1,param2,param3,param4);
      }
      
      public function addFileAt(param1:uint, param2:String, param3:ByteArray = null, param4:Boolean = true) : FZipFile
      {
         if(filesList == null)
         {
            filesList = [];
         }
         if(filesDict == null)
         {
            filesDict = new Dictionary();
         }
         else if(filesDict[param2])
         {
            throw new Error("File already exists: " + param2 + ". Please remove first.");
         }
         var _loc5_:FZipFile = new FZipFile();
         _loc5_.filename = param2;
         _loc5_.setContent(param3,param4);
         if(param1 >= filesList.length)
         {
            filesList.push(_loc5_);
         }
         else
         {
            filesList.splice(param1,0,_loc5_);
         }
         filesDict[param2] = _loc5_;
         return _loc5_;
      }
      
      public function addFileFromStringAt(param1:uint, param2:String, param3:String, param4:String = "utf-8", param5:Boolean = true) : FZipFile
      {
         if(filesList == null)
         {
            filesList = [];
         }
         if(filesDict == null)
         {
            filesDict = new Dictionary();
         }
         else if(filesDict[param2])
         {
            throw new Error("File already exists: " + param2 + ". Please remove first.");
         }
         var _loc6_:FZipFile = new FZipFile();
         _loc6_.filename = param2;
         _loc6_.setContentAsString(param3,param4,param5);
         if(param1 >= filesList.length)
         {
            filesList.push(_loc6_);
         }
         else
         {
            filesList.splice(param1,0,_loc6_);
         }
         filesDict[param2] = _loc6_;
         return _loc6_;
      }
      
      public function removeFileAt(param1:uint) : FZipFile
      {
         var _loc2_:* = null;
         if(filesList != null && filesDict != null && param1 < filesList.length)
         {
            _loc2_ = filesList[param1] as FZipFile;
            if(_loc2_ != null)
            {
               filesList.splice(param1,1);
               delete filesDict[_loc2_.filename];
               return _loc2_;
            }
         }
         return null;
      }
      
      protected function parse(param1:IDataInput) : Boolean
      {
         while(parseFunc(param1))
         {
         }
         return parseFunc === parseIdle;
      }
      
      protected function parseIdle(param1:IDataInput) : Boolean
      {
         return false;
      }
      
      protected function parseSignature(param1:IDataInput) : Boolean
      {
         var _loc2_:* = 0;
         if(param1.bytesAvailable >= 4)
         {
            _loc2_ = uint(param1.readUnsignedInt());
            var _loc3_:* = _loc2_;
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
                                          throw new Error("Unknown record signature: 0x" + _loc2_.toString(16));
                                       }
                                    }
                                    addr35:
                                    parseFunc = parseIdle;
                                 }
                                 addr34:
                                 §§goto(addr35);
                              }
                              addr33:
                              §§goto(addr34);
                           }
                           addr32:
                           §§goto(addr33);
                        }
                        addr31:
                        §§goto(addr32);
                     }
                     addr30:
                     §§goto(addr31);
                  }
                  addr29:
                  §§goto(addr30);
               }
               §§goto(addr29);
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
      
      protected function parseLocalfile(param1:IDataInput) : Boolean
      {
         if(currentFile.parse(param1))
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
      
      protected function findDataDescriptor(param1:IDataInput) : Boolean
      {
         var _loc2_:* = 0;
         while(param1.bytesAvailable > 0)
         {
            _loc2_ = uint(param1.readUnsignedByte());
            ddSignature = ddSignature >>> 8 | _loc2_ << 24;
            if(ddSignature == 134695760)
            {
               ddBuffer.length = ddBuffer.length - 3;
               parseFunc = validateDataDescriptor;
               return true;
            }
            ddBuffer.writeByte(_loc2_);
         }
         return false;
      }
      
      protected function validateDataDescriptor(param1:IDataInput) : Boolean
      {
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(param1.bytesAvailable >= 12)
         {
            _loc4_ = uint(param1.readUnsignedInt());
            _loc3_ = uint(param1.readUnsignedInt());
            _loc2_ = uint(param1.readUnsignedInt());
            if(ddBuffer.length == _loc3_)
            {
               ddBuffer.position = 0;
               currentFile._crc32 = _loc4_;
               currentFile._sizeCompressed = _loc3_;
               currentFile._sizeUncompressed = _loc2_;
               currentFile.parseContent(ddBuffer);
               onFileLoaded();
               parseFunc = parseSignature;
            }
            else
            {
               ddBuffer.writeUnsignedInt(_loc4_);
               ddBuffer.writeUnsignedInt(_loc3_);
               ddBuffer.writeUnsignedInt(_loc2_);
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
      
      protected function progressHandler(param1:Event) : void
      {
         dispatchEvent(param1.clone());
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
      
      protected function defaultHandler(param1:Event) : void
      {
         dispatchEvent(param1.clone());
      }
      
      protected function defaultErrorHandler(param1:Event) : void
      {
         close();
         dispatchEvent(param1.clone());
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
