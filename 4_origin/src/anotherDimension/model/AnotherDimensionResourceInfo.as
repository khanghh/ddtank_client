package anotherDimension.model
{
   import ddt.data.player.PlayerInfo;
   
   public class AnotherDimensionResourceInfo
   {
       
      
      public var resourceLevel:int;
      
      public var monsterId:int;
      
      public var resourcePos:int;
      
      public var resourcePlayerInfo:PlayerInfo;
      
      public var resourceState:int;
      
      public var isHave:Boolean;
      
      public var haveResourceTime:Date;
      
      public var haveResourceLast:int;
      
      public var lastMaxMunites:int;
      
      public var itemId:int;
      
      public var itemCountPerHour:int;
      
      public function AnotherDimensionResourceInfo()
      {
         super();
      }
   }
}
