package cardSystem.data
{
   import com.pickgliss.ui.controls.cell.INotSameHeightListCellData;
   
   public class CardAchievementInfo implements INotSameHeightListCellData
   {
       
      
      public var attack:int;
      
      public var damage:int;
      
      public var defence:int;
      
      public var recovery:int;
      
      public var luck:int;
      
      public var MaxHp:int;
      
      public var magicAttack:int;
      
      public var magicDefend:int;
      
      public var AchievementID:int;
      
      public var Desc:String;
      
      public var IsPrompt:int;
      
      public var Name:String;
      
      public var Type:int;
      
      public var Honor_id:int;
      
      public var RequireGroupid:int;
      
      public var RequireGroupNum:int;
      
      public var RequireNum:int;
      
      public var RequireType:int;
      
      public function CardAchievementInfo(){super();}
      
      public function getCellHeight() : Number{return 0;}
   }
}
