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
      
      public function TexpInfoTipArea()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         addEventListener("rollOver",__over);
         addEventListener("rollOut",__out);
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("texpSystem.texpInfoTipArea.size");
         graphics.beginFill(0,0);
         graphics.drawRect(0,0,_loc1_.x,_loc1_.y);
         graphics.endFill();
         _tip = new TexpInfoTip();
      }
      
      public function set info(param1:PlayerInfo) : void
      {
         if(!param1)
         {
            return;
         }
         _info = param1;
         _tip.tipData = _info;
      }
      
      private function __over(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         if(!_tip.parent && _info)
         {
            _loc2_ = localToGlobal(new Point(0,0));
            _tip.x = _loc2_.x;
            _tip.y = _loc2_.y + width;
            LayerManager.Instance.addToLayer(_tip,2);
         }
      }
      
      private function __out(param1:MouseEvent) : void
      {
         if(_tip.parent)
         {
            _tip.parent.removeChild(_tip);
         }
      }
      
      public function dispose() : void
      {
         removeEventListener("rollOver",__over);
         removeEventListener("rollOut",__out);
         ObjectUtils.disposeObject(_tip);
         _tip = null;
         _info = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
