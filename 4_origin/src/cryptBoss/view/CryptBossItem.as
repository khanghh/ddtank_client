package cryptBoss.view
{
   import com.pickgliss.events.ComponentEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import cryptBoss.data.CryptBossItemInfo;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CryptBossItem extends Sprite implements Disposeable
   {
       
      
      private var _info:CryptBossItemInfo;
      
      private var _iconMovie:MovieClip;
      
      private var _clickSp:Sprite;
      
      private var _lightStarVec:Vector.<Bitmap>;
      
      private var _isOpen:Boolean;
      
      private var _setFrame:CryptBossSetFrame;
      
      public function CryptBossItem(param1:CryptBossItemInfo)
      {
         super();
         _info = param1;
         _lightStarVec = new Vector.<Bitmap>();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc1_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc4_:Array = _info.openWeekDaysArr;
         var _loc3_:int = TimeManager.Instance.currentDay;
         _loc9_ = 0;
         while(_loc9_ < _loc4_.length)
         {
            if(_loc4_[_loc9_] == _loc3_)
            {
               _isOpen = true;
               break;
            }
            _loc9_++;
         }
         _iconMovie = ComponentFactory.Instance.creat("asset.cryptBoss.light.icon" + _info.id);
         _clickSp = new Sprite();
         if(_isOpen)
         {
            _loc2_ = "cryptBoss.open.starPos";
            _loc5_ = 25;
            _loc8_ = 166;
            _loc1_ = 170;
            _iconMovie.gotoAndStop(2);
            PositionUtils.setPos(this,"cryptBoss.open.itemPos" + _info.id);
         }
         else
         {
            _loc2_ = "cryptBoss.notOpen.starPos";
            _loc5_ = 24;
            _loc1_ = 100;
            _loc8_ = 100;
            _iconMovie.gotoAndStop(1);
            PositionUtils.setPos(this,"cryptBoss.notOpen.itemPos" + _info.id);
         }
         _clickSp.graphics.beginFill(16777215,0);
         _clickSp.graphics.drawRect(0,0,_loc8_,_loc1_);
         _clickSp.graphics.endFill();
         _clickSp.buttonMode = true;
         addChild(_iconMovie);
         addChild(_clickSp);
         _loc7_ = 0;
         while(_loc7_ < _info.star)
         {
            _loc6_ = ComponentFactory.Instance.creat("asset.cryptBoss.star");
            if(_loc7_ == 0)
            {
               PositionUtils.setPos(_loc6_,_loc2_);
            }
            else
            {
               _loc6_.x = _loc6_.x + (_lightStarVec[0].x + _loc7_ * _loc5_);
               _loc6_.y = _lightStarVec[0].y;
            }
            addChild(_loc6_);
            _lightStarVec.push(_loc6_);
            _loc7_++;
         }
      }
      
      private function initEvent() : void
      {
         _clickSp.addEventListener("click",__fightSetHandler);
      }
      
      public function get info() : CryptBossItemInfo
      {
         return _info;
      }
      
      protected function __fightSetHandler(param1:MouseEvent) : void
      {
         if(!_isOpen)
         {
            return;
         }
         SoundManager.instance.playButtonSound();
         _setFrame = ComponentFactory.Instance.creatCustomObject("CryptBossSetFrame",[_info]);
         _setFrame.addEventListener("dispose",frameDisposeHandler,false,0,true);
         LayerManager.Instance.addToLayer(_setFrame,3,true,1);
      }
      
      private function frameDisposeHandler(param1:ComponentEvent) : void
      {
         if(_setFrame)
         {
            _setFrame.removeEventListener("dispose",frameDisposeHandler);
         }
         _setFrame = null;
      }
      
      private function removeEvent() : void
      {
         _clickSp.removeEventListener("click",__fightSetHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         _iconMovie.stop();
         removeChild(_iconMovie);
         _iconMovie = null;
         var _loc3_:int = 0;
         var _loc2_:* = _lightStarVec;
         for each(var _loc1_ in _lightStarVec)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         _clickSp.graphics.clear();
         removeChild(_clickSp);
         _info = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
