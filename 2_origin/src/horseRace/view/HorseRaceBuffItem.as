package horseRace.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import horseRace.controller.HorseRaceManager;
   import horseRace.events.HorseRaceEvents;
   
   public class HorseRaceBuffItem extends Sprite implements Disposeable
   {
       
      
      private var _buffIndex:int;
      
      private var _buffType:int;
      
      private var _bg:Bitmap;
      
      private var _daojishi:MovieClip;
      
      private var _buffObj1:BaseButton;
      
      private var _buffObj2:BaseButton;
      
      private var _buffObj3:BaseButton;
      
      private var _buffObj4:BaseButton;
      
      private var _buffObj5:BaseButton;
      
      private var _buffObj6:BaseButton;
      
      private var _buffObj7:BaseButton;
      
      private var _buffObj8:BaseButton;
      
      private var buffConfig:Array;
      
      public function HorseRaceBuffItem($buffType:int, $buffIndex:int)
      {
         super();
         _buffIndex = $buffIndex;
         _buffType = $buffType;
         buffConfig = ServerConfigManager.instance.horseGameBuffConfig;
         initView();
         initEvent();
      }
      
      private function getConfigByID(id:int) : int
      {
         var lastTime:int = 0;
         var buffStr:String = buffConfig[id - 1];
         var arr:Array = buffStr.split(",");
         var buffId:int = arr[0];
         if(buffId == id)
         {
            lastTime = arr[1];
         }
         return lastTime;
      }
      
      private function initView() : void
      {
         if(_buffIndex == 1)
         {
            _bg = ComponentFactory.Instance.creat("horseRace.raceView.buffViewItem1");
         }
         else if(_buffIndex == 2)
         {
            _bg = ComponentFactory.Instance.creat("horseRace.raceView.buffViewItem2");
         }
         _daojishi = ComponentFactory.Instance.creat("horseRace.raceView.buffView.itemMc");
         _daojishi.visible = false;
         PositionUtils.setPos(_daojishi,"horseRace.raceView.buffView.itemMcPos");
         _buffObj1 = ComponentFactory.Instance.creatComponentByStylename("horseRace.raceView.buffView.buffObj1");
         _buffObj1.tipData = LanguageMgr.GetTranslation("horseRace.raceView.buffView.buffObjDiscripe1",getConfigByID(1));
         PositionUtils.setPos(_buffObj1,"horseRace.raceView.buffView.buffObjPos");
         _buffObj1.width = 42;
         _buffObj1.height = 42;
         _buffObj1.visible = false;
         _buffObj1.addEventListener("click",_buffObjClick);
         addChild(_buffObj1);
         _buffObj2 = ComponentFactory.Instance.creatComponentByStylename("horseRace.raceView.buffView.buffObj2");
         _buffObj2.tipData = LanguageMgr.GetTranslation("horseRace.raceView.buffView.buffObjDiscripe2",getConfigByID(2));
         PositionUtils.setPos(_buffObj2,"horseRace.raceView.buffView.buffObjPos");
         _buffObj2.width = 42;
         _buffObj2.height = 42;
         _buffObj2.visible = false;
         _buffObj2.addEventListener("click",_buffObjClick);
         addChild(_buffObj2);
         _buffObj3 = ComponentFactory.Instance.creatComponentByStylename("horseRace.raceView.buffView.buffObj3");
         _buffObj3.tipData = LanguageMgr.GetTranslation("horseRace.raceView.buffView.buffObjDiscripe3",getConfigByID(3));
         PositionUtils.setPos(_buffObj3,"horseRace.raceView.buffView.buffObjPos");
         _buffObj3.width = 42;
         _buffObj3.height = 42;
         _buffObj3.visible = false;
         _buffObj3.addEventListener("click",_buffObjClick);
         addChild(_buffObj3);
         _buffObj4 = ComponentFactory.Instance.creatComponentByStylename("horseRace.raceView.buffView.buffObj4");
         _buffObj4.tipData = LanguageMgr.GetTranslation("horseRace.raceView.buffView.buffObjDiscripe4",getConfigByID(4));
         PositionUtils.setPos(_buffObj4,"horseRace.raceView.buffView.buffObjPos");
         _buffObj4.width = 42;
         _buffObj4.height = 42;
         _buffObj4.visible = false;
         _buffObj4.addEventListener("click",_buffObjClick);
         addChild(_buffObj4);
         _buffObj5 = ComponentFactory.Instance.creatComponentByStylename("horseRace.raceView.buffView.buffObj5");
         _buffObj5.tipData = LanguageMgr.GetTranslation("horseRace.raceView.buffView.buffObjDiscripe5",getConfigByID(5));
         PositionUtils.setPos(_buffObj5,"horseRace.raceView.buffView.buffObjPos");
         _buffObj5.width = 42;
         _buffObj5.height = 42;
         _buffObj5.visible = false;
         _buffObj5.addEventListener("click",_buffObjClick);
         addChild(_buffObj5);
         _buffObj6 = ComponentFactory.Instance.creatComponentByStylename("horseRace.raceView.buffView.buffObj6");
         _buffObj6.tipData = LanguageMgr.GetTranslation("horseRace.raceView.buffView.buffObjDiscripe6",getConfigByID(6));
         PositionUtils.setPos(_buffObj6,"horseRace.raceView.buffView.buffObjPos");
         _buffObj6.width = 42;
         _buffObj6.height = 42;
         _buffObj6.visible = false;
         _buffObj6.addEventListener("click",_buffObjClick);
         addChild(_buffObj6);
         _buffObj7 = ComponentFactory.Instance.creatComponentByStylename("horseRace.raceView.buffView.buffObj7");
         _buffObj7.tipData = LanguageMgr.GetTranslation("horseRace.raceView.buffView.buffObjDiscripe7",getConfigByID(7));
         PositionUtils.setPos(_buffObj7,"horseRace.raceView.buffView.buffObjPos");
         _buffObj7.width = 42;
         _buffObj7.height = 42;
         _buffObj7.visible = false;
         _buffObj7.addEventListener("click",_buffObjClick);
         addChild(_buffObj7);
         _buffObj8 = ComponentFactory.Instance.creatComponentByStylename("horseRace.raceView.buffView.buffObj8");
         _buffObj8.tipData = LanguageMgr.GetTranslation("horseRace.raceView.buffView.buffObjDiscripe8",getConfigByID(8));
         PositionUtils.setPos(_buffObj8,"horseRace.raceView.buffView.buffObjPos");
         _buffObj8.width = 42;
         _buffObj8.height = 42;
         _buffObj8.visible = false;
         _buffObj8.addEventListener("click",_buffObjClick);
         addChild(_buffObj8);
         addChild(_bg);
         addChild(_daojishi);
         addChild(_buffObj1);
         addChild(_buffObj2);
         addChild(_buffObj3);
         addChild(_buffObj4);
         addChild(_buffObj5);
         addChild(_buffObj6);
         addChild(_buffObj7);
         addChild(_buffObj8);
      }
      
      public function setShowBuff($buffType:int, minute:int) : void
      {
         _buffType = $buffType;
         if($buffType == 0)
         {
            _daojishi.visible = true;
            _daojishi.gotoAndStop(minute);
            if(_buffObj1)
            {
               _buffObj1.visible = false;
            }
            if(_buffObj2)
            {
               _buffObj2.visible = false;
            }
            if(_buffObj3)
            {
               _buffObj3.visible = false;
            }
            if(_buffObj4)
            {
               _buffObj5.visible = false;
            }
            if(_buffObj5)
            {
               _buffObj5.visible = false;
            }
            if(_buffObj6)
            {
               _buffObj6.visible = false;
            }
            if(_buffObj7)
            {
               _buffObj7.visible = false;
            }
            if(_buffObj8)
            {
               _buffObj8.visible = false;
            }
         }
         if(minute == -1)
         {
            _daojishi.visible = false;
            if(_buffObj1)
            {
               _buffObj1.visible = false;
            }
            if(_buffObj2)
            {
               _buffObj2.visible = false;
            }
            if(_buffObj3)
            {
               _buffObj3.visible = false;
            }
            if(_buffObj4)
            {
               _buffObj5.visible = false;
            }
            if(_buffObj5)
            {
               _buffObj5.visible = false;
            }
            if(_buffObj6)
            {
               _buffObj6.visible = false;
            }
            if(_buffObj7)
            {
               _buffObj7.visible = false;
            }
            if(_buffObj8)
            {
               _buffObj8.visible = false;
            }
         }
      }
      
      public function setShowBuffObj($buffType:int) : void
      {
         if($buffType != 0)
         {
            _daojishi.visible = false;
            showBuffObjByType($buffType);
         }
      }
      
      public function showBuffObjByType(type:int) : void
      {
         if(type == 1)
         {
            _buffObj1.visible = true;
            _buffObj2.visible = false;
            _buffObj3.visible = false;
            _buffObj4.visible = false;
            _buffObj5.visible = false;
            _buffObj6.visible = false;
            _buffObj7.visible = false;
            _buffObj8.visible = false;
         }
         else if(type == 2)
         {
            _buffObj1.visible = false;
            _buffObj2.visible = true;
            _buffObj3.visible = false;
            _buffObj4.visible = false;
            _buffObj5.visible = false;
            _buffObj6.visible = false;
            _buffObj7.visible = false;
            _buffObj8.visible = false;
         }
         else if(type == 3)
         {
            _buffObj1.visible = false;
            _buffObj2.visible = false;
            _buffObj3.visible = true;
            _buffObj4.visible = false;
            _buffObj5.visible = false;
            _buffObj6.visible = false;
            _buffObj7.visible = false;
            _buffObj8.visible = false;
         }
         else if(type == 4)
         {
            _buffObj1.visible = false;
            _buffObj2.visible = false;
            _buffObj3.visible = false;
            _buffObj4.visible = true;
            _buffObj5.visible = false;
            _buffObj6.visible = false;
            _buffObj7.visible = false;
            _buffObj8.visible = false;
         }
         else if(type == 5)
         {
            _buffObj1.visible = false;
            _buffObj2.visible = false;
            _buffObj3.visible = false;
            _buffObj4.visible = false;
            _buffObj5.visible = true;
            _buffObj6.visible = false;
            _buffObj7.visible = false;
            _buffObj8.visible = false;
         }
         else if(type == 6)
         {
            _buffObj1.visible = false;
            _buffObj2.visible = false;
            _buffObj3.visible = false;
            _buffObj4.visible = false;
            _buffObj5.visible = false;
            _buffObj6.visible = true;
            _buffObj7.visible = false;
            _buffObj8.visible = false;
         }
         else if(type == 7)
         {
            _buffObj1.visible = false;
            _buffObj2.visible = false;
            _buffObj3.visible = false;
            _buffObj4.visible = false;
            _buffObj5.visible = false;
            _buffObj6.visible = false;
            _buffObj7.visible = true;
            _buffObj8.visible = false;
         }
         else if(type == 8)
         {
            _buffObj1.visible = false;
            _buffObj2.visible = false;
            _buffObj3.visible = false;
            _buffObj4.visible = false;
            _buffObj5.visible = false;
            _buffObj6.visible = false;
            _buffObj7.visible = false;
            _buffObj8.visible = true;
         }
         else if(type == 0)
         {
            _buffObj1.visible = false;
            _buffObj2.visible = false;
            _buffObj3.visible = false;
            _buffObj4.visible = false;
            _buffObj5.visible = false;
            _buffObj6.visible = false;
            _buffObj7.visible = false;
            _buffObj8.visible = false;
         }
      }
      
      private function _buffObjClick(e:MouseEvent) : void
      {
         HorseRaceManager.Instance.dispatchEvent(new HorseRaceEvents("HORSERACE_USE_DAOJU",_buffIndex));
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
      }
   }
}
