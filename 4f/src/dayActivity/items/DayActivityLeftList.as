package dayActivity.items
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import dayActivity.ActivityData;
   import dayActivity.DayActiveData;
   import dayActivity.DayActivityManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.TimeManager;
   import flash.display.Sprite;
   
   public class DayActivityLeftList extends Sprite implements Disposeable
   {
       
      
      private var _tilte:DayActivityLeftTitleItem;
      
      private var _num:int;
      
      private var _expriedNum:int;
      
      public function DayActivityLeftList(param1:String, param2:Vector.<ActivityData>, param3:Boolean){super();}
      
      private function initView(param1:String, param2:Vector.<ActivityData>, param3:Boolean) : void{}
      
      private function compareDay(param1:int, param2:String) : Boolean{return false;}
      
      public function setTxt(param1:String) : void{}
      
      public function dispose() : void{}
   }
}
