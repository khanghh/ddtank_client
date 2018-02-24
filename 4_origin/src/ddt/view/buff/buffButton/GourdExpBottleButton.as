package ddt.view.buff.buffButton
{
   import com.pickgliss.ui.LayerManager;
   import ddt.data.BuffInfo;
   import ddt.data.GourdExpBottleInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import trainer.view.NewHandContainer;
   
   public class GourdExpBottleButton extends BuffButton
   {
       
      
      private var _helpViewShow:Boolean = true;
      
      private var _gourdHelpTipView:GourdHelpTipView;
      
      private var _gourdInfo:GourdExpBottleInfo;
      
      public function GourdExpBottleButton()
      {
         super("asset.core.expBottle.icon");
         _bg.width = 42;
         _bg.height = 42;
         initView();
      }
      
      public function get gourdInfo() : GourdExpBottleInfo
      {
         return _gourdInfo;
      }
      
      public function set gourdInfo(param1:GourdExpBottleInfo) : void
      {
         _gourdInfo = param1;
         updataButton();
      }
      
      private function initView() : void
      {
         info = new BuffInfo(27);
         filters = null;
         var _loc1_:* = 0.909090909090909;
         this.scaleY = _loc1_;
         this.scaleX = _loc1_;
         this.buttonMode = true;
         this.useHandCursor = true;
      }
      
      private function updataButton() : void
      {
         var _loc1_:InventoryItemInfo = ItemManager.fillByID(_gourdInfo.TemplateID);
         _info.description = LanguageMgr.GetTranslation("GourdExpBottle.gourdHelpTipView.tipsText",_gourdInfo.Exp,_loc1_.Property2);
      }
      
      override protected function __onclick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         super.__onclick(param1);
         if(_gourdInfo.IsFrist == 1)
         {
            NewHandContainer.Instance.clearArrowByID(153);
         }
         if(_helpViewShow)
         {
            param1.stopImmediatePropagation();
            if(!_gourdHelpTipView)
            {
               _gourdHelpTipView = new GourdHelpTipView();
            }
            _gourdHelpTipView.visible = true;
            _loc2_ = this.localToGlobal(new Point(this.width - 50,this.y + this.height));
            PositionUtils.setPos(_gourdHelpTipView,_loc2_);
            LayerManager.Instance.addToLayer(_gourdHelpTipView,3);
            stage.addEventListener("click",__closeChairChnnel);
         }
         else if(_gourdHelpTipView)
         {
            _gourdHelpTipView.visible = false;
         }
         _helpViewShow = !!_helpViewShow?false:true;
      }
      
      protected function __closeChairChnnel(param1:MouseEvent) : void
      {
         if(!_gourdHelpTipView)
         {
            return;
         }
         if(param1.target != _gourdHelpTipView.viewBg)
         {
            stage.removeEventListener("click",__closeChairChnnel);
            if(_gourdHelpTipView)
            {
               _gourdHelpTipView.visible = false;
               _helpViewShow = true;
            }
         }
      }
      
      override public function dispose() : void
      {
         if(_gourdHelpTipView)
         {
            _gourdHelpTipView.dispose();
            _gourdHelpTipView = null;
         }
         super.dispose();
      }
   }
}
