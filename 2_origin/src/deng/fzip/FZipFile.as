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
      
      public function FZipFile(filenameEncoding:String = "utf-8")
      {
         parseFunc = parseFileHead;
         super();
         _filenameEncoding = filenameEncoding;
         _extraFields = new Dictionary();
         _content = new ByteArray();
         _content.endian = "bigEndian";
      }
      
      public function get date() : Date
      {
         return _date;
      }
      
      public function set date(value:Date) : void
      {
         _date = value != null?value:new Date();
      }
      
      public function get filename() : String
      {
         return _filename;
      }
      
      public function set filename(value:String) : void
      {
         _filename = value;
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
      
      public function set content(data:ByteArray) : void
      {
         setContent(data);
      }
      
      public function setContent(data:ByteArray, doCompress:Boolean = true) : void
      {
         if(data != null && data.length > 0)
         {
            data.position = 0;
            data.readBytes(_content,0,data.length);
            _crc32 = ChecksumUtil.CRC32(_content);
            _hasAdler32 = false;
         }
         else
         {
            _content.length = 0;
            _content.position = 0;
            isCompressed = false;
         }
         if(doCompress)
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
      
      public function getContentAsString(recompress:Boolean = true, charset:String = "utf-8") : String
      {
         var str:* = null;
         if(isCompressed)
         {
            uncompress();
         }
         _content.position = 0;
         if(charset == "utf-8")
         {
            str = _content.readUTFBytes(_content.bytesAvailable);
         }
         else
         {
            str = _content.readMultiByte(_content.bytesAvailable,charset);
         }
         _content.position = 0;
         if(recompress)
         {
            compress();
         }
         return str;
      }
      
      public function setContentAsString(value:String, charset:String = "utf-8", doCompress:Boolean = true) : void
      {
         _content.length = 0;
         _content.position = 0;
         isCompressed = false;
         if(value != null && value.length > 0)
         {
            if(charset == "utf-8")
            {
               _content.writeUTFBytes(value);
            }
            else
            {
               _content.writeMultiByte(value,charset);
            }
            _crc32 = ChecksumUtil.CRC32(_content);
            _hasAdler32 = false;
         }
         if(doCompress)
         {
            compress();
         }
         else
         {
            _sizeCompressed = _content.length;
            _sizeUncompressed = _content.length;
         }
      }
      
      public function serialize(stream:IDataOutput, includeAdler32:Boolean, centralDir:Boolean = false, centralDirOffset:uint = 0) : uint
      {
         var extraBytes:* = null;
         var compressed:Boolean = false;
         if(stream == null)
         {
            return 0;
         }
         if(centralDir)
         {
            stream.writeUnsignedInt(33639248);
            stream.writeShort(_versionHost << 8 | 20);
         }
         else
         {
            stream.writeUnsignedInt(67324752);
         }
         stream.writeShort(_versionHost << 8 | 20);
         stream.writeShort(_filenameEncoding == "utf-8"?2048:0);
         stream.writeShort(!!isCompressed?8:0);
         var d:Date = _date != null?_date:new Date();
         var msdosTime:uint = uint(d.getSeconds()) | uint(d.getMinutes()) << 5 | uint(d.getHours()) << 11;
         var msdosDate:uint = uint(d.getDate()) | uint(d.getMonth() + 1) << 5 | uint(d.getFullYear() - 1980) << 9;
         stream.writeShort(msdosTime);
         stream.writeShort(msdosDate);
         stream.writeUnsignedInt(_crc32);
         stream.writeUnsignedInt(_sizeCompressed);
         stream.writeUnsignedInt(_sizeUncompressed);
         var ba:ByteArray = new ByteArray();
         ba.endian = "littleEndian";
         if(_filenameEncoding == "utf-8")
         {
            ba.writeUTFBytes(_filename);
         }
         else
         {
            ba.writeMultiByte(_filename,_filenameEncoding);
         }
         var filenameSize:uint = ba.position;
         var _loc18_:int = 0;
         var _loc17_:* = _extraFields;
         for(var headerId in _extraFields)
         {
            extraBytes = _extraFields[headerId] as ByteArray;
            if(extraBytes != null)
            {
               ba.writeShort(uint(headerId));
               ba.writeShort(uint(extraBytes.length));
               ba.writeBytes(extraBytes);
            }
         }
         if(includeAdler32)
         {
            if(!_hasAdler32)
            {
               compressed = isCompressed;
               if(compressed)
               {
                  uncompress();
               }
               _adler32 = ChecksumUtil.Adler32(_content,0,_content.length);
               _hasAdler32 = true;
               if(compressed)
               {
                  compress();
               }
            }
            ba.writeShort(56026);
            ba.writeShort(4);
            ba.writeUnsignedInt(_adler32);
         }
         var extrafieldsSize:uint = ba.position - filenameSize;
         if(centralDir && _comment.length > 0)
         {
            if(_filenameEncoding == "utf-8")
            {
               ba.writeUTFBytes(_comment);
            }
            else
            {
               ba.writeMultiByte(_comment,_filenameEncoding);
            }
         }
         var commentSize:uint = ba.position - filenameSize - extrafieldsSize;
         stream.writeShort(filenameSize);
         stream.writeShort(extrafieldsSize);
         if(centralDir)
         {
            stream.writeShort(commentSize);
            stream.writeShort(0);
            stream.writeShort(0);
            stream.writeUnsignedInt(0);
            stream.writeUnsignedInt(centralDirOffset);
         }
         if(filenameSize + extrafieldsSize + commentSize > 0)
         {
            stream.writeBytes(ba);
         }
         var fileSize:uint = 0;
         if(!centralDir && _content.length > 0)
         {
            if(isCompressed)
            {
               if(HAS_UNCOMPRESS || HAS_INFLATE)
               {
                  fileSize = _content.length;
                  stream.writeBytes(_content,0,fileSize);
               }
               else
               {
                  fileSize = _content.length - 6;
                  stream.writeBytes(_content,2,fileSize);
               }
            }
            else
            {
               fileSize = _content.length;
               stream.writeBytes(_content,0,fileSize);
            }
         }
         var size:uint = 30 + filenameSize + extrafieldsSize + commentSize + fileSize;
         if(centralDir)
         {
            size = size + 16;
         }
         return size;
      }
      
      function parse(stream:IDataInput) : Boolean
      {
         while(stream.bytesAvailable && parseFunc(stream))
         {
         }
         return parseFunc === parseFileIdle;
      }
      
      protected function parseFileIdle(stream:IDataInput) : Boolean
      {
         return false;
      }
      
      protected function parseFileHead(stream:IDataInput) : Boolean
      {
         if(stream.bytesAvailable >= 30)
         {
            parseHead(stream);
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
      
      protected function parseFileHeadExt(stream:IDataInput) : Boolean
      {
         if(stream.bytesAvailable >= _sizeFilename + _sizeExtra)
         {
            parseHeadExt(stream);
            parseFunc = parseFileContent;
            return true;
         }
         return false;
      }
      
      protected function parseFileContent(stream:IDataInput) : Boolean
      {
         var continueParsing:Boolean = true;
         if(_hasDataDescriptor)
         {
            parseFunc = parseFileIdle;
            continueParsing = false;
         }
         else if(_sizeCompressed == 0)
         {
            parseFunc = parseFileIdle;
         }
         else if(stream.bytesAvailable >= _sizeCompressed)
         {
            parseContent(stream);
            parseFunc = parseFileIdle;
         }
         else
         {
            continueParsing = false;
         }
         return continueParsing;
      }
      
      protected function parseHead(data:IDataInput) : void
      {
         var vSrc:uint = data.readUnsignedShort();
         _versionHost = vSrc >> 8;
         _versionNumber = Math.floor((vSrc & 255) / 10) + "." + (vSrc & 255) % 10;
         var flag:uint = data.readUnsignedShort();
         _compressionMethod = data.readUnsignedShort();
         _encrypted = (flag & 1) !== 0;
         _hasDataDescriptor = (flag & 8) !== 0;
         _hasCompressedPatchedData = (flag & 32) !== 0;
         if((flag & 800) !== 0)
         {
            _filenameEncoding = "utf-8";
         }
         if(_compressionMethod === 6)
         {
            _implodeDictSize = (flag & 2) !== 0?8192:Number(4096);
            _implodeShannonFanoTrees = (flag & 4) !== 0?3:2;
         }
         else if(_compressionMethod === 8)
         {
            _deflateSpeedOption = (flag & 6) >> 1;
         }
         var msdosTime:uint = data.readUnsignedShort();
         var msdosDate:uint = data.readUnsignedShort();
         var sec:* = msdosTime & 31;
         var min:* = (msdosTime & 2016) >> 5;
         var hour:* = (msdosTime & 63488) >> 11;
         var day:* = msdosDate & 31;
         var month:* = (msdosDate & 480) >> 5;
         var year:int = ((msdosDate & 65024) >> 9) + 1980;
         _date = new Date(year,month - 1,day,hour,min,sec,0);
         _crc32 = data.readUnsignedInt();
         _sizeCompressed = data.readUnsignedInt();
         _sizeUncompressed = data.readUnsignedInt();
         _sizeFilename = data.readUnsignedShort();
         _sizeExtra = data.readUnsignedShort();
      }
      
      protected function parseHeadExt(data:IDataInput) : void
      {
         var headerId:* = 0;
         var dataSize:* = 0;
         var extraBytes:* = null;
         if(_filenameEncoding == "utf-8")
         {
            _filename = data.readUTFBytes(_sizeFilename);
         }
         else
         {
            _filename = data.readMultiByte(_sizeFilename,_filenameEncoding);
         }
         var bytesLeft:uint = _sizeExtra;
         while(bytesLeft > 4)
         {
            headerId = uint(data.readUnsignedShort());
            dataSize = uint(data.readUnsignedShort());
            if(dataSize > bytesLeft)
            {
               throw new Error("Parse error in file " + _filename + ": Extra field data size too big.");
            }
            if(headerId === 56026 && dataSize === 4)
            {
               _adler32 = data.readUnsignedInt();
               _hasAdler32 = true;
            }
            else if(dataSize > 0)
            {
               extraBytes = new ByteArray();
               data.readBytes(extraBytes,0,dataSize);
               _extraFields[headerId] = extraBytes;
            }
            bytesLeft = bytesLeft - (dataSize + 4);
         }
         if(bytesLeft > 0)
         {
            data.readBytes(new ByteArray(),0,bytesLeft);
         }
      }
      
      function parseContent(data:IDataInput) : void
      {
         var flg:* = 0;
         if(_compressionMethod === 8 && !_encrypted)
         {
            if(HAS_UNCOMPRESS || HAS_INFLATE)
            {
               data.readBytes(_content,0,_sizeCompressed);
            }
            else if(_hasAdler32)
            {
               _content.writeByte(120);
               flg = uint(~_deflateSpeedOption << 6 & 192);
               flg = uint(flg + (31 - (30720 | flg) % 31));
               _content.writeByte(flg);
               data.readBytes(_content,2,_sizeCompressed);
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
            data.readBytes(_content,0,_sizeCompressed);
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
