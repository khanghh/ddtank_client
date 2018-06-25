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
      
      public function DayActivityLeftList(str:String, list:Vector.<ActivityData>, bool:Boolean)
      {
         super();
         _num = list.length;
         _expriedNum = 0;
         initView(str,list,bool);
      }
      
      private function initView(str:String, list:Vector.<ActivityData>, bool:Boolean) : void
      {
         var i:int = 0;
         var item:* = null;
         _expriedNum = 0;
         _tilte = new DayActivityLeftTitleItem(str,_num);
         addChild(_tilte);
         var acitiveDataList:Vector.<DayActiveData> = DayActivityManager.Instance.acitiveDataList;
         var today:int = TimeManager.Instance.serverDate.day;
         for(i = 0; i < _num; i++)
         {
            if(list[i].ActivityType == 6)
            {
               if(!compareDay(today,DayActivityManager.Instance.YUANGUJULONG_DAYOFWEEK))
               {
                  _expriedNum = Number(_expriedNum) + 1;
                  continue;
               }
            }
            if(list[i].ActivityType == 18)
            {
               if(!compareDay(today,DayActivityManager.Instance.ANYEBOJUE_DAYOFWEEK))
               {
                  _expriedNum = Number(_expriedNum) + 1;
                  continue;
               }
            }
            if(list[i].ActivityType == 19)
            {
               if(!compareDay(today,DayActivityManager.Instance.ZUQIUBOSS_DAYOFWEEK))
               {
                  _expriedNum = Number(_expriedNum) + 1;
                  continue;
               }
            }
            item = new DayActivityLeftListItem(bool,list[i]);
            item.setTxt2(list[i].OverCount);
            if(list[i].JumpType > 0)
            {
               item.tipData = LanguageMgr.GetTranslation("ddt.battleGroud.itemTips",list[i].ActivePoint,list[i].Description);
            }
            else
            {
               item.tipData = LanguageMgr.GetTranslation("ddt.battleGroud.btnTip",list[i].ActivePoint);
            }
            item.x = 2;
            item.y = 30 + 25 * (i - _expriedNum);
            addChild(item);
         }
      }
      
      private function compareDay(day:int, activeDays:String) : Boolean
      {
         var dayArr:Array = activeDays.split(",");
         if(dayArr.indexOf("" + day) == -1)
         {
            return false;
         }
         return true;
      }
      
      public function setTxt(str:String) : void
      {
         _tilte.setTxt(LanguageMgr.GetTranslation(str,_num - _expriedNum));
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
