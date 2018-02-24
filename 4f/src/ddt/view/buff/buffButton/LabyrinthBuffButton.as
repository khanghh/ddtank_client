package ddt.view.buff.buffButton
{
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.container.VBox;
   import ddt.data.BuffInfo;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class LabyrinthBuffButton extends BuffButton
   {
       
      
      private var _labyrinthBuffTipView:LabyrinthBuffTipView;
      
      private var _helpViewShow:Boolean = false;
      
      public function LabyrinthBuffButton(){super(null);}
      
      private function initView() : void{}
      
      override protected function __onclick(param1:MouseEvent) : void{}
      
      protected function __closeChairChnnel(param1:MouseEvent) : void{}
      
      private function checkIsVBoxChild(param1:*, param2:VBox) : Boolean{return false;}
      
      override public function dispose() : void{}
   }
}
