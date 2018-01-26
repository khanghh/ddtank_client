package ddt.view.buff.buffButton
{
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import ddt.data.BuffInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.RandomSuitCardManager;
   import ddt.utils.PositionUtils;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class GrowHelpBuffButton extends BuffButton
   {
       
      
      private var _growHelpBtn:ScaleFrameImage;
      
      private var _helpViewShow:Boolean = true;
      
      private var _growHelpTipView:GrowHelpTipView;
      
      public var buffArray:Array;
      
      public function GrowHelpBuffButton(){super(null);}
      
      private function initView() : void{}
      
      override protected function __onclick(param1:MouseEvent) : void{}
      
      protected function __closeChairChnnel(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
