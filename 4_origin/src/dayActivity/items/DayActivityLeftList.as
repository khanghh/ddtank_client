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
      
      public function DayActivityLeftList(param1:String, param2:Vector.<ActivityData>, param3:Boolean)
      {
         super();
         _num = param2.length;
         _expriedNum = 0;
         initView(param1,param2,param3);
      }
      
      private function initView(param1:String, param2:Vector.<ActivityData>, param3:Boolean) : void
      {
         var _loc7_:int = 0;
         var _loc5_:* = null;
         _expriedNum = 0;
         _tilte = new DayActivityLeftTitleItem(param1,_num);
         addChild(_tilte);
         var _loc4_:Vector.<DayActiveData> = DayActivityManager.Instance.acitiveDataList;
         var _loc6_:int = TimeManager.Instance.serverDate.day;
         _loc7_ = 0;
         for(; _loc7_ < _num; _loc7_++)
         {
            if(param2[_loc7_].ActivityType == 6)
            {
               if(!compareDay(_loc6_,DayActivityManager.Instance.YUANGUJULONG_DAYOFWEEK))
               {
                  _expriedNum = Number(_expriedNum) + 1;
                  continue;
               }
            }
            if(param2[_loc7_].ActivityType == 18)
            {
               if(!compareDay(_loc6_,DayActivityManager.Instance.ANYEBOJUE_DAYOFWEEK))
               {
                  _expriedNum = Number(_expriedNum) + 1;
                  continue;
               }
            }
            if(param2[_loc7_].ActivityType == 19)
            {
               if(!compareDay(_loc6_,DayActivityManager.Instance.ZUQIUBOSS_DAYOFWEEK))
               {
                  _expriedNum = Number(_expriedNum) + 1;
                  continue;
               }
            }
            _loc5_ = new DayActivityLeftListItem(param3,param2[_loc7_]);
            _loc5_.setTxt2(param2[_loc7_].OverCount);
            if(param2[_loc7_].JumpType > 0)
            {
               _loc5_.tipData = LanguageMgr.GetTranslation("ddt.battleGroud.itemTips",param2[_loc7_].ActivePoint,param2[_loc7_].Description);
            }
            else
            {
               _loc5_.tipData = LanguageMgr.GetTranslation("ddt.battleGroud.btnTip",param2[_loc7_].ActivePoint);
            }
            _loc5_.x = 2;
            _loc5_.y = 30 + 25 * (_loc7_ - _expriedNum);
            addChild(_loc5_);
         }
      }
      
      private function compareDay(param1:int, param2:String) : Boolean
      {
         var _loc3_:Array = param2.split(",");
         if(_loc3_.indexOf("" + param1) == -1)
         {
            return false;
         }
         return true;
      }
      
      public function setTxt(param1:String) : void
      {
         _tilte.setTxt(LanguageMgr.GetTranslation(param1,_num - _expriedNum));
      }
      
      public function dispose() : void
      {
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
