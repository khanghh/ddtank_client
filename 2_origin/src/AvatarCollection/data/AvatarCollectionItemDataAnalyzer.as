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
      
      public function AvatarCollectionItemDataAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var tmpVo:* = null;
         var tmpId:int = 0;
         var list:* = null;
         var j:int = 0;
         var id:int = 0;
         var xml:XML = new XML(data);
         _maleItemDic = new DictionaryData();
         _femaleItemDic = new DictionaryData();
         _weaponItemDic = new DictionaryData();
         _allGoodsTemplateIDlist = new DictionaryData();
         _maleItemList = new Vector.<AvatarCollectionItemVo>();
         _femaleItemList = new Vector.<AvatarCollectionItemVo>();
         _weaponItemList = new Vector.<AvatarCollectionItemVo>();
         _realItemIdDic = new DictionaryData();
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               tmpVo = new AvatarCollectionItemVo();
               tmpVo.id = xmllist[i].@ID;
               tmpVo.itemId = xmllist[i].@TemplateID;
               tmpVo.proArea = xmllist[i].@Description;
               tmpVo.needGold = xmllist[i].@Cost;
               tmpVo.sex = xmllist[i].@Sex;
               tmpVo.Type = xmllist[i].@Type;
               tmpVo.OtherTemplateID = xmllist[i].@OtherTemplateID;
               tmpId = tmpVo.id;
               if(tmpVo.Type == 1)
               {
                  if(tmpVo.sex == 1)
                  {
                     if(!_maleItemDic[tmpId])
                     {
                        _maleItemDic[tmpId] = new DictionaryData();
                     }
                     _maleItemDic[tmpId].add(tmpVo.itemId,tmpVo);
                     _maleItemList.push(tmpVo);
                  }
                  else
                  {
                     if(!_femaleItemDic[tmpId])
                     {
                        _femaleItemDic[tmpId] = new DictionaryData();
                     }
                     _femaleItemDic[tmpId].add(tmpVo.itemId,tmpVo);
                     _femaleItemList.push(tmpVo);
                  }
               }
               else
               {
                  if(!_weaponItemDic[tmpId])
                  {
                     _weaponItemDic[tmpId] = new DictionaryData();
                  }
                  _weaponItemDic[tmpId].add(tmpVo.itemId,tmpVo);
                  _weaponItemList.push(tmpVo);
               }
               _allGoodsTemplateIDlist[tmpVo.itemId] = true;
               list = tmpVo.OtherTemplateID == ""?[]:tmpVo.OtherTemplateID.split("|");
               for(j = 0; j < list.length; )
               {
                  id = list[j];
                  if(id != 0)
                  {
                     _realItemIdDic.add(id,tmpVo.itemId);
                  }
                  j++;
               }
               _realItemIdDic.add(tmpVo.itemId,tmpVo.itemId);
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
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
