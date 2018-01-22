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
      
      public function LabyrinthBuffButton()
      {
         super("asset.core.LabyrinthBuffAsset");
         _tipDirctions = "7,4,5,1";
         initView();
      }
      
      private function initView() : void
      {
         info = new BuffInfo(17);
         info.description = LanguageMgr.GetTranslation("ddt.buffinfo.labyrinthBuffhelp");
         this.buttonMode = true;
         this.useHandCursor = true;
      }
      
      override protected function __onclick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         super.__onclick(param1);
         if(!_helpViewShow)
         {
            param1.stopImmediatePropagation();
            _labyrinthBuffTipView = new LabyrinthBuffTipView();
            _helpViewShow = true;
            _loc2_ = this.localToGlobal(new Point(this.x + this.width,this.y + this.height));
            _loc2_.x = _loc2_.x - 252;
            PositionUtils.setPos(_labyrinthBuffTipView,_loc2_);
            LayerManager.Instance.addToLayer(_labyrinthBuffTipView,3);
            stage.addEventListener("click",__closeChairChnnel);
         }
         else if(_labyrinthBuffTipView)
         {
            _labyrinthBuffTipView.dispose();
            _labyrinthBuffTipView = null;
            _helpViewShow = false;
         }
      }
      
      protected function __closeChairChnnel(param1:MouseEvent) : void
      {
         if(!_labyrinthBuffTipView)
         {
            return;
         }
         if(!(param1.stageX >= _labyrinthBuffTipView.x && param1.stageX <= _labyrinthBuffTipView.x + _labyrinthBuffTipView.width && param1.stageY >= _labyrinthBuffTipView.y && param1.stageY <= _labyrinthBuffTipView.y + _labyrinthBuffTipView.height))
         {
            stage.removeEventListener("click",__closeChairChnnel);
            if(_labyrinthBuffTipView)
            {
               _labyrinthBuffTipView.dispose();
               _labyrinthBuffTipView = null;
               _helpViewShow = false;
            }
         }
      }
      
      private function checkIsVBoxChild(param1:*, param2:VBox) : Boolean
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param2.numChildren)
         {
            if(param1 == param2.getChildAt(_loc3_))
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      override public function dispose() : void
      {
         if(_labyrinthBuffTipView)
         {
            _labyrinthBuffTipView.dispose();
            _labyrinthBuffTipView = null;
         }
         super.dispose();
      }
   }
}
