package deng.fzip
{
   import deng.utils.ChecksumUtil;
   import flash.utils.*;
   
   public class FZipFile
   {
      
      public static const COMPRESSION_NONE:int = 0;
      
      public static const COMPRESSION_SHRUNK:int = 1;
      
      public static const COMPRESSION_REDUCED_1:int = 2;
      
      public static const COMPRESSION_REDUCED_2:int = 3;
      
      public static const COMPRESSION_REDUCED_3:int = 4;
      
      public static const COMPRESSION_REDUCED_4:int = 5;
      
      public static const COMPRESSION_IMPLODED:int = 6;
      
      public static const COMPRESSION_TOKENIZED:int = 7;
      
      public static const COMPRESSION_DEFLATED:int = 8;
      
      public static const COMPRESSION_DEFLATED_EXT:int = 9;
      
      public static const COMPRESSION_IMPLODED_PKWARE:int = 10;
      
      protected static var HAS_UNCOMPRESS:Boolean = describeType(ByteArray).factory.method.(@name == "uncompress").parameter.length() > 0;
      
      protected static var HAS_INFLATE:Boolean = describeType(ByteArray).factory.method.(@name == "inflate").length() > 0;
      
      {
         var _loc1_:* = describeType(ByteArray).factory.method;
         var _loc2_:int = 0;
         var _loc4_:* = new XMLList("");
         var _loc5_:* = describeType(ByteArray).factory.method;
         var _loc6_:int = 0;
         _loc1_ = new XMLList("");
      }
      
      protected var _versionHost:int = 0;
      
      protected var _versionNumber:String = "2.0";
      
      protected var _compressionMethod:int = 8;
      
      protected var _encrypted:Boolean = false;
      
      protected var _implodeDictSize:int = -1;
      
      protected var _implodeShannonFanoTrees:int = -1;
      
      protected var _deflateSpeedOption:int = -1;
      
      protected var _hasDataDescriptor:Boolean = false;
      
      protected var _hasCompressedPatchedData:Boolean = false;
      
      protected var _date:Date;
      
      protected var _adler32:uint;
      
      protected var _hasAdler32:Boolean = false;
      
      protected var _sizeFilename:uint = 0;
      
      protected var _sizeExtra:uint = 0;
      
      protected var _filename:String = "";
      
      protected var _filenameEncoding:String;
      
      protected var _extraFields:Dictionary;
      
      protected var _comment:String = "";
      
      protected var _content:ByteArray;
      
      var _crc32:uint;
      
      var _sizeCompressed:uint = 0;
      
      var _sizeUncompressed:uint = 0;
      
      protected var isCompressed:Boolean = false;
      
      protected var parseFunc:Function;
      
      public function FZipFile(param1:String = "utf-8")
      {
         parseFunc = parseFileHead;
         super();
         _filenameEncoding = param1;
         _extraFields = new Dictionary();
         _content = new ByteArray();
         _content.endian = "bigEndian";
      }
      
      public function get date() : Date
      {
         return _date;
      }
      
      public function set date(param1:Date) : void
      {
         _date = param1 != null?param1:new Date();
      }
      
      public function get filename() : String
      {
         return _filename;
      }
      
      public function set filename(param1:String) : void
      {
         _filename = param1;
      }
      
      function get hasDataDescriptor() : Boolean
      {
         return _hasDataDescriptor;
      }
      
      public function get content() : ByteArray
      {
         if(isCompressed)
         {
            uncompress();
         }
         return _content;
      }
      
      public function set content(param1:ByteArray) : void
      {
         setContent(param1);
      }
      
      public function setContent(param1:ByteArray, param2:Boolean = true) : void
      {
         if(param1 != null && param1.length > 0)
         {
            param1.position = 0;
            param1.readBytes(_content,0,param1.length);
            _crc32 = ChecksumUtil.CRC32(_content);
            _hasAdler32 = false;
         }
         else
         {
            _content.length = 0;
            _content.position = 0;
            isCompressed = false;
         }
         if(param2)
         {
            compress();
         }
         else
         {
            _sizeCompressed = _content.length;
            _sizeUncompressed = _content.length;
         }
      }
      
      public function get versionNumber() : String
      {
         return _versionNumber;
      }
      
      public function get sizeCompressed() : uint
      {
         return _sizeCompressed;
      }
      
      public function get sizeUncompressed() : uint
      {
         return _sizeUncompressed;
      }
      
      public function getContentAsString(param1:Boolean = true, param2:String = "utf-8") : String
      {
         var _loc3_:* = null;
         if(isCompressed)
         {
            uncompress();
         }
         _content.position = 0;
         if(param2 == "utf-8")
         {
            _loc3_ = _content.readUTFBytes(_content.bytesAvailable);
         }
         else
         {
            _loc3_ = _content.readMultiByte(_content.bytesAvailable,param2);
         }
         _content.position = 0;
         if(param1)
         {
            compress();
         }
         return _loc3_;
      }
      
      public function setContentAsString(param1:String, param2:String = "utf-8", param3:Boolean = true) : void
      {
         _content.length = 0;
         _content.position = 0;
         isCompressed = false;
         if(param1 != null && param1.length > 0)
         {
            if(param2 == "utf-8")
            {
               _content.writeUTFBytes(param1);
            }
            else
            {
               _content.writeMultiByte(param1,param2);
            }
            _crc32 = ChecksumUtil.CRC32(_content);
            _hasAdler32 = false;
         }
         if(param3)
         {
            compress();
         }
         else
         {
            _sizeCompressed = _content.length;
            _sizeUncompressed = _content.length;
         }
      }
      
      public function serialize(param1:IDataOutput, param2:Boolean, param3:Boolean = false, param4:uint = 0) : uint
      {
         var _loc7_:* = null;
         var _loc13_:Boolean = false;
         if(param1 == null)
         {
            return 0;
         }
         if(param3)
         {
            param1.writeUnsignedInt(33639248);
            param1.writeShort(_versionHost << 8 | 20);
         }
         else
         {
            param1.writeUnsignedInt(67324752);
         }
         param1.writeShort(_versionHost << 8 | 20);
         param1.writeShort(_filenameEncoding == "utf-8"?2048:0);
         param1.writeShort(!!isCompressed?8:0);
         var _loc6_:Date = _date != null?_date:new Date();
         var _loc15_:uint = uint(_loc6_.getSeconds()) | uint(_loc6_.getMinutes()) << 5 | uint(_loc6_.getHours()) << 11;
         var _loc10_:uint = uint(_loc6_.getDate()) | uint(_loc6_.getMonth() + 1) << 5 | uint(_loc6_.getFullYear() - 1980) << 9;
         param1.writeShort(_loc15_);
         param1.writeShort(_loc10_);
         param1.writeUnsignedInt(_crc32);
         param1.writeUnsignedInt(_sizeCompressed);
         param1.writeUnsignedInt(_sizeUncompressed);
         var _loc9_:ByteArray = new ByteArray();
         _loc9_.endian = "littleEndian";
         if(_filenameEncoding == "utf-8")
         {
            _loc9_.writeUTFBytes(_filename);
         }
         else
         {
            _loc9_.writeMultiByte(_filename,_filenameEncoding);
         }
         var _loc14_:uint = _loc9_.position;
         var _loc18_:int = 0;
         var _loc17_:* = _extraFields;
         for(var _loc16_ in _extraFields)
         {
            _loc7_ = _extraFields[_loc16_] as ByteArray;
            if(_loc7_ != null)
            {
               _loc9_.writeShort(uint(_loc16_));
               _loc9_.writeShort(uint(_loc7_.length));
               _loc9_.writeBytes(_loc7_);
            }
         }
         if(param2)
         {
            if(!_hasAdler32)
            {
               _loc13_ = isCompressed;
               if(_loc13_)
               {
                  uncompress();
               }
               _adler32 = ChecksumUtil.Adler32(_content,0,_content.length);
               _hasAdler32 = true;
               if(_loc13_)
               {
                  compress();
               }
            }
            _loc9_.writeShort(56026);
            _loc9_.writeShort(4);
            _loc9_.writeUnsignedInt(_adler32);
         }
         var _loc8_:uint = _loc9_.position - _loc14_;
         if(param3 && _comment.length > 0)
         {
            if(_filenameEncoding == "utf-8")
            {
               _loc9_.writeUTFBytes(_comment);
            }
            else
            {
               _loc9_.writeMultiByte(_comment,_filenameEncoding);
            }
         }
         var _loc5_:uint = _loc9_.position - _loc14_ - _loc8_;
         param1.writeShort(_loc14_);
         param1.writeShort(_loc8_);
         if(param3)
         {
            param1.writeShort(_loc5_);
            param1.writeShort(0);
            param1.writeShort(0);
            param1.writeUnsignedInt(0);
            param1.writeUnsignedInt(param4);
         }
         if(_loc14_ + _loc8_ + _loc5_ > 0)
         {
            param1.writeBytes(_loc9_);
         }
         var _loc12_:uint = 0;
         if(!param3 && _content.length > 0)
         {
            if(isCompressed)
            {
               if(HAS_UNCOMPRESS || HAS_INFLATE)
               {
                  _loc12_ = _content.length;
                  param1.writeBytes(_content,0,_loc12_);
               }
               else
               {
                  _loc12_ = _content.length - 6;
                  param1.writeBytes(_content,2,_loc12_);
               }
            }
            else
            {
               _loc12_ = _content.length;
               param1.writeBytes(_content,0,_loc12_);
            }
         }
         var _loc11_:uint = 30 + _loc14_ + _loc8_ + _loc5_ + _loc12_;
         if(param3)
         {
            _loc11_ = _loc11_ + 16;
         }
         return _loc11_;
      }
      
      function parse(param1:IDataInput) : Boolean
      {
         while(param1.bytesAvailable && parseFunc(param1))
         {
         }
         return parseFunc === parseFileIdle;
      }
      
      protected function parseFileIdle(param1:IDataInput) : Boolean
      {
         return false;
      }
      
      protected function parseFileHead(param1:IDataInput) : Boolean
      {
         if(param1.bytesAvailable >= 30)
         {
            parseHead(param1);
            if(_sizeFilename + _sizeExtra > 0)
            {
               parseFunc = parseFileHeadExt;
            }
            else
            {
               parseFunc = parseFileContent;
            }
            return true;
         }
         return false;
      }
      
      protected function parseFileHeadExt(param1:IDataInput) : Boolean
      {
         if(param1.bytesAvailable >= _sizeFilename + _sizeExtra)
         {
            parseHeadExt(param1);
            parseFunc = parseFileContent;
            return true;
         }
         return false;
      }
      
      protected function parseFileContent(param1:IDataInput) : Boolean
      {
         var _loc2_:Boolean = true;
         if(_hasDataDescriptor)
         {
            parseFunc = parseFileIdle;
            _loc2_ = false;
         }
         else if(_sizeCompressed == 0)
         {
            parseFunc = parseFileIdle;
         }
         else if(param1.bytesAvailable >= _sizeCompressed)
         {
            parseContent(param1);
            parseFunc = parseFileIdle;
         }
         else
         {
            _loc2_ = false;
         }
         return _loc2_;
      }
      
      protected function parseHead(param1:IDataInput) : void
      {
         var _loc6_:uint = param1.readUnsignedShort();
         _versionHost = _loc6_ >> 8;
         _versionNumber = Math.floor((_loc6_ & 255) / 10) + "." + (_loc6_ & 255) % 10;
         var _loc3_:uint = param1.readUnsignedShort();
         _compressionMethod = param1.readUnsignedShort();
         _encrypted = (_loc3_ & 1) !== 0;
         _hasDataDescriptor = (_loc3_ & 8) !== 0;
         _hasCompressedPatchedData = (_loc3_ & 32) !== 0;
         if((_loc3_ & 800) !== 0)
         {
            _filenameEncoding = "utf-8";
         }
         if(_compressionMethod === 6)
         {
            _implodeDictSize = (_loc3_ & 2) !== 0?8192:Number(4096);
            _implodeShannonFanoTrees = (_loc3_ & 4) !== 0?3:2;
         }
         else if(_compressionMethod === 8)
         {
            _deflateSpeedOption = (_loc3_ & 6) >> 1;
         }
         var _loc9_:uint = param1.readUnsignedShort();
         var _loc7_:uint = param1.readUnsignedShort();
         var _loc4_:* = _loc9_ & 31;
         var _loc2_:* = (_loc9_ & 2016) >> 5;
         var _loc11_:* = (_loc9_ & 63488) >> 11;
         var _loc10_:* = _loc7_ & 31;
         var _loc5_:* = (_loc7_ & 480) >> 5;
         var _loc8_:int = ((_loc7_ & 65024) >> 9) + 1980;
         _date = new Date(_loc8_,_loc5_ - 1,_loc10_,_loc11_,_loc2_,_loc4_,0);
         _crc32 = param1.readUnsignedInt();
         _sizeCompressed = param1.readUnsignedInt();
         _sizeUncompressed = param1.readUnsignedInt();
         _sizeFilename = param1.readUnsignedShort();
         _sizeExtra = param1.readUnsignedShort();
      }
      
      protected function parseHeadExt(param1:IDataInput) : void
      {
         var _loc5_:* = 0;
         var _loc4_:* = 0;
         var _loc3_:* = null;
         if(_filenameEncoding == "utf-8")
         {
            _filename = param1.readUTFBytes(_sizeFilename);
         }
         else
         {
            _filename = param1.readMultiByte(_sizeFilename,_filenameEncoding);
         }
         var _loc2_:uint = _sizeExtra;
         while(_loc2_ > 4)
         {
            _loc5_ = uint(param1.readUnsignedShort());
            _loc4_ = uint(param1.readUnsignedShort());
            if(_loc4_ > _loc2_)
            {
               throw new Error("Parse error in file " + _filename + ": Extra field data size too big.");
            }
            if(_loc5_ === 56026 && _loc4_ === 4)
            {
               _adler32 = param1.readUnsignedInt();
               _hasAdler32 = true;
            }
            else if(_loc4_ > 0)
            {
               _loc3_ = new ByteArray();
               param1.readBytes(_loc3_,0,_loc4_);
               _extraFields[_loc5_] = _loc3_;
            }
            _loc2_ = _loc2_ - (_loc4_ + 4);
         }
         if(_loc2_ > 0)
         {
            param1.readBytes(new ByteArray(),0,_loc2_);
         }
      }
      
      function parseContent(param1:IDataInput) : void
      {
         var _loc2_:* = 0;
         if(_compressionMethod === 8 && !_encrypted)
         {
            if(HAS_UNCOMPRESS || HAS_INFLATE)
            {
               param1.readBytes(_content,0,_sizeCompressed);
            }
            else if(_hasAdler32)
            {
               _content.writeByte(120);
               _loc2_ = uint(~_deflateSpeedOption << 6 & 192);
               _loc2_ = uint(_loc2_ + (31 - (30720 | _loc2_) % 31));
               _content.writeByte(_loc2_);
               param1.readBytes(_content,2,_sizeCompressed);
               _content.position = _content.length;
               _content.writeUnsignedInt(_adler32);
            }
            else
            {
               throw new Error("Adler32 checksum not found.");
            }
            isCompressed = true;
         }
         else if(_compressionMethod == 0)
         {
            param1.readBytes(_content,0,_sizeCompressed);
            isCompressed = false;
         }
         else
         {
            throw new Error("Compression method " + _compressionMethod + " is not supported.");
         }
         _content.position = 0;
      }
      
      protected function compress() : void
      {
         if(!isCompressed)
         {
            if(_content.length > 0)
            {
               _content.position = 0;
               _sizeUncompressed = _content.length;
               if(HAS_INFLATE)
               {
                  _content.deflate();
                  _sizeCompressed = _content.length;
               }
               else if(HAS_UNCOMPRESS)
               {
                  _content.compress.apply(_content,["deflate"]);
                  _sizeCompressed = _content.length;
               }
               else
               {
                  _content.compress();
                  _sizeCompressed = _content.length - 6;
               }
               _content.position = 0;
               isCompressed = true;
            }
            else
            {
               _sizeCompressed = 0;
               _sizeUncompressed = 0;
            }
         }
      }
      
      protected function uncompress() : void
      {
         if(isCompressed && _content.length > 0)
         {
            _content.position = 0;
            if(HAS_INFLATE)
            {
               _content.inflate();
            }
            else if(HAS_UNCOMPRESS)
            {
               _content.uncompress.apply(_content,["deflate"]);
            }
            else
            {
               _content.uncompress();
            }
            _content.position = 0;
            isCompressed = false;
         }
      }
      
      public function toString() : String
      {
         return "[FZipFile]\n  name:" + _filename + "\n  date:" + _date + "\n  sizeCompressed:" + _sizeCompressed + "\n  sizeUncompressed:" + _sizeUncompressed + "\n  versionHost:" + _versionHost + "\n  versionNumber:" + _versionNumber + "\n  compressionMethod:" + _compressionMethod + "\n  encrypted:" + _encrypted + "\n  hasDataDescriptor:" + _hasDataDescriptor + "\n  hasCompressedPatchedData:" + _hasCompressedPatchedData + "\n  filenameEncoding:" + _filenameEncoding + "\n  crc32:" + _crc32.toString(16) + "\n  adler32:" + _adler32.toString(16);
      }
   }
}
