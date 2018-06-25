package hall.player.vo
{
   import flash.utils.Dictionary;
   
   public class PlayerPetsInfo
   {
       
      
      private var _disDic:Dictionary;
      
      public function PlayerPetsInfo()
      {
         super();
         _disDic = new Dictionary();
      }
      
      public function set distanceDic(value:String) : void
      {
         var i:int = 0;
         var disArr:* = null;
         var dicArr:Array = value.split(",");
         for(i = 0; i < dicArr.length; )
         {
            disArr = dicArr[i].split(":");
            _disDic[disArr[0]] = disArr[1];
            i++;
         }
      }
      
      public function get disDic() : Dictionary
      {
         return _disDic;
      }
   }
}
