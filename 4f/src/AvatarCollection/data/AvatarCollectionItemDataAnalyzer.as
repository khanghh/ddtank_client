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
      
      public function AvatarCollectionItemDataAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get weaponItemDic() : DictionaryData{return null;}
      
      public function get maleItemDic() : DictionaryData{return null;}
      
      public function get femaleItemDic() : DictionaryData{return null;}
      
      public function get maleItemList() : Vector.<AvatarCollectionItemVo>{return null;}
      
      public function get femaleItemList() : Vector.<AvatarCollectionItemVo>{return null;}
      
      public function get weaponItemList() : Vector.<AvatarCollectionItemVo>{return null;}
      
      public function get allGoodsTemplateIDlist() : DictionaryData{return null;}
      
      public function get realItemIdDic() : DictionaryData{return null;}
   }
}
