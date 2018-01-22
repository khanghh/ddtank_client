package AvatarCollection.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import road7th.data.DictionaryData;
   
   public class AvatarCollectionItemDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _maleItemDic:DictionaryData;
      
      private var _femaleItemDic:DictionaryData;
      
      private var _weaponItemDic:DictionaryData;
      
      private var _maleItemList:Vector.<AvatarCollectionItemVo>;
      
      private var _femaleItemList:Vector.<AvatarCollectionItemVo>;
      
      private var _weaponItemList:Vector.<AvatarCollectionItemVo>;
      
      private var _allGoodsTemplateIDlist:DictionaryData;
      
      private var _realItemIdDic:DictionaryData;
      
      public function AvatarCollectionItemDataAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc6_:* = null;
         var _loc9_:int = 0;
         var _loc3_:* = null;
         var _loc8_:int = 0;
         var _loc4_:* = null;
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:XML = new XML(param1);
         _maleItemDic = new DictionaryData();
         _femaleItemDic = new DictionaryData();
         _weaponItemDic = new DictionaryData();
         _allGoodsTemplateIDlist = new DictionaryData();
         _maleItemList = new Vector.<AvatarCollectionItemVo>();
         _femaleItemList = new Vector.<AvatarCollectionItemVo>();
         _weaponItemList = new Vector.<AvatarCollectionItemVo>();
         _realItemIdDic = new DictionaryData();
         if(_loc5_.@value == "true")
         {
            _loc6_ = _loc5_..Item;
            _loc9_ = 0;
            while(_loc9_ < _loc6_.length())
            {
               _loc3_ = new AvatarCollectionItemVo();
               _loc3_.id = _loc6_[_loc9_].@ID;
               _loc3_.itemId = _loc6_[_loc9_].@TemplateID;
               _loc3_.proArea = _loc6_[_loc9_].@Description;
               _loc3_.needGold = _loc6_[_loc9_].@Cost;
               _loc3_.sex = _loc6_[_loc9_].@Sex;
               _loc3_.Type = _loc6_[_loc9_].@Type;
               _loc3_.OtherTemplateID = _loc6_[_loc9_].@OtherTemplateID;
               _loc8_ = _loc3_.id;
               if(_loc3_.Type == 1)
               {
                  if(_loc3_.sex == 1)
                  {
                     if(!_maleItemDic[_loc8_])
                     {
                        _maleItemDic[_loc8_] = new DictionaryData();
                     }
                     _maleItemDic[_loc8_].add(_loc3_.itemId,_loc3_);
                     _maleItemList.push(_loc3_);
                  }
                  else
                  {
                     if(!_femaleItemDic[_loc8_])
                     {
                        _femaleItemDic[_loc8_] = new DictionaryData();
                     }
                     _femaleItemDic[_loc8_].add(_loc3_.itemId,_loc3_);
                     _femaleItemList.push(_loc3_);
                  }
               }
               else
               {
                  if(!_weaponItemDic[_loc8_])
                  {
                     _weaponItemDic[_loc8_] = new DictionaryData();
                  }
                  _weaponItemDic[_loc8_].add(_loc3_.itemId,_loc3_);
                  _weaponItemList.push(_loc3_);
               }
               _allGoodsTemplateIDlist[_loc3_.itemId] = true;
               _loc4_ = _loc3_.OtherTemplateID == ""?[]:_loc3_.OtherTemplateID.split("|");
               _loc7_ = 0;
               while(_loc7_ < _loc4_.length)
               {
                  _loc2_ = _loc4_[_loc7_];
                  if(_loc2_ != 0)
                  {
                     _realItemIdDic.add(_loc2_,_loc3_.itemId);
                  }
                  _loc7_++;
               }
               _realItemIdDic.add(_loc3_.itemId,_loc3_.itemId);
               _loc9_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc5_.@message;
            onAnalyzeError();
            onAnalyzeError();
         }
      }
      
      public function get weaponItemDic() : DictionaryData
      {
         return _weaponItemDic;
      }
      
      public function get maleItemDic() : DictionaryData
      {
         return _maleItemDic;
      }
      
      public function get femaleItemDic() : DictionaryData
      {
         return _femaleItemDic;
      }
      
      public function get maleItemList() : Vector.<AvatarCollectionItemVo>
      {
         return _maleItemList;
      }
      
      public function get femaleItemList() : Vector.<AvatarCollectionItemVo>
      {
         return _femaleItemList;
      }
      
      public function get weaponItemList() : Vector.<AvatarCollectionItemVo>
      {
         return _weaponItemList;
      }
      
      public function get allGoodsTemplateIDlist() : DictionaryData
      {
         return _allGoodsTemplateIDlist;
      }
      
      public function get realItemIdDic() : DictionaryData
      {
         return _realItemIdDic;
      }
   }
}
