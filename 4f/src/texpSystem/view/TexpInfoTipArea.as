package texpSystem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class TexpInfoTipArea extends Sprite implements Disposeable
   {
       
      
      private var _tip:TexpInfoTip;
      
      private var _info:PlayerInfo;
      
      public function TexpInfoTipArea(){super();}
      
      private function init() : void{}
      
      public function set info(param1:PlayerInfo) : void{}
      
      private function __over(param1:MouseEvent) : void{}
      
      private function __out(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
