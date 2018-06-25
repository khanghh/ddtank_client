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
      
      public function CryptBossItem(data:CryptBossItemInfo)
      {
         super();
         _info = data;
         _lightStarVec = new Vector.<Bitmap>();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var posStr:* = null;
         var dis:int = 0;
         var spWidth:int = 0;
         var spHeight:int = 0;
         var i:int = 0;
         var k:int = 0;
         var star:* = null;
         var daysArr:Array = _info.openWeekDaysArr;
         var currentDay:int = TimeManager.Instance.currentDay;
         for(i = 0; i < daysArr.length; )
         {
            if(daysArr[i] == currentDay)
            {
               _isOpen = true;
               break;
            }
            i++;
         }
         _iconMovie = ComponentFactory.Instance.creat("asset.cryptBoss.light.icon" + _info.id);
         _clickSp = new Sprite();
         if(_isOpen)
         {
            posStr = "cryptBoss.open.starPos";
            dis = 25;
            spWidth = 166;
            spHeight = 170;
            _iconMovie.gotoAndStop(2);
            PositionUtils.setPos(this,"cryptBoss.open.itemPos" + _info.id);
         }
         else
         {
            posStr = "cryptBoss.notOpen.starPos";
            dis = 24;
            spHeight = 100;
            spWidth = 100;
            _iconMovie.gotoAndStop(1);
            PositionUtils.setPos(this,"cryptBoss.notOpen.itemPos" + _info.id);
         }
         _clickSp.graphics.beginFill(16777215,0);
         _clickSp.graphics.drawRect(0,0,spWidth,spHeight);
         _clickSp.graphics.endFill();
         _clickSp.buttonMode = true;
         addChild(_iconMovie);
         addChild(_clickSp);
         for(k = 0; k < _info.star; )
         {
            star = ComponentFactory.Instance.creat("asset.cryptBoss.star");
            if(k == 0)
            {
               PositionUtils.setPos(star,posStr);
            }
            else
            {
               star.x = star.x + (_lightStarVec[0].x + k * dis);
               star.y = _lightStarVec[0].y;
            }
            addChild(star);
            _lightStarVec.push(star);
            k++;
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
      
      protected function __fightSetHandler(event:MouseEvent) : void
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
      
      private function frameDisposeHandler(event:ComponentEvent) : void
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
         for each(var star in _lightStarVec)
         {
            ObjectUtils.disposeObject(star);
            star = null;
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
