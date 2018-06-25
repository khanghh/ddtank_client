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
      
      override protected function __onclick(event:MouseEvent) : void
      {
         var viewPos:* = null;
         super.__onclick(event);
         if(!_helpViewShow)
         {
            event.stopImmediatePropagation();
            _labyrinthBuffTipView = new LabyrinthBuffTipView();
            _helpViewShow = true;
            viewPos = this.localToGlobal(new Point(this.x + this.width,this.y + this.height));
            viewPos.x = viewPos.x - 252;
            PositionUtils.setPos(_labyrinthBuffTipView,viewPos);
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
      
      protected function __closeChairChnnel(event:MouseEvent) : void
      {
         if(!_labyrinthBuffTipView)
         {
            return;
         }
         if(!(event.stageX >= _labyrinthBuffTipView.x && event.stageX <= _labyrinthBuffTipView.x + _labyrinthBuffTipView.width && event.stageY >= _labyrinthBuffTipView.y && event.stageY <= _labyrinthBuffTipView.y + _labyrinthBuffTipView.height))
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
      
      private function checkIsVBoxChild(target:*, buffItemVBox:VBox) : Boolean
      {
         var i:int = 0;
         for(i = 0; i < buffItemVBox.numChildren; )
         {
            if(target == buffItemVBox.getChildAt(i))
            {
               return true;
            }
            i++;
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
