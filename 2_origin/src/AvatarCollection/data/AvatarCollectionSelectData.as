package AvatarCollection.data
{
   public class AvatarCollectionSelectData
   {
       
      
      public var value:AvatarCollectionUnitVo;
      
      public var selected:Boolean = false;
      
      public function AvatarCollectionSelectData(param1:AvatarCollectionUnitVo, param2:Boolean)
      {
         super();
         value = param1;
         selected = param2;
      }
   }
}
