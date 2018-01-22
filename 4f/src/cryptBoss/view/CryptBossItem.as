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
      
      public function CryptBossItem(param1:CryptBossItemInfo){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      public function get info() : CryptBossItemInfo{return null;}
      
      protected function __fightSetHandler(param1:MouseEvent) : void{}
      
      private function frameDisposeHandler(param1:ComponentEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
