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
      
      public function GrowHelpBuffButton()
      {
         super("asset.core.growHelp");
         initView();
      }
      
      private function initView() : void
      {
         info = new BuffInfo(14);
         info.description = LanguageMgr.GetTranslation("ddt.buffinfo.growhelp");
         this.buttonMode = true;
         this.useHandCursor = true;
      }
      
      override protected function __onclick(event:MouseEvent) : void
      {
         var len:int = 0;
         var i:int = 0;
         var viewPos:* = null;
         super.__onclick(event);
         if(_helpViewShow)
         {
            event.stopImmediatePropagation();
            len = buffArray.length;
            for(i = 0; i < len; )
            {
               if(buffArray[i] is RandomSuitButton)
               {
                  (buffArray[i] as RandomSuitButton).info.IsExist = RandomSuitCardManager.getInstance().isExist();
               }
               i++;
            }
            if(!_growHelpTipView)
            {
               _growHelpTipView = new GrowHelpTipView();
               _growHelpTipView.addBuff(buffArray);
            }
            _growHelpTipView.visible = true;
            viewPos = this.localToGlobal(new Point(this.x + this.width,this.y + this.height));
            PositionUtils.setPos(_growHelpTipView,viewPos);
            LayerManager.Instance.addToLayer(_growHelpTipView,3);
            stage.addEventListener("click",__closeChairChnnel);
         }
         else if(_growHelpTipView)
         {
            _growHelpTipView.visible = false;
         }
         _helpViewShow = !!_helpViewShow?false:true;
      }
      
      protected function __closeChairChnnel(event:MouseEvent) : void
      {
         if(!_growHelpTipView)
         {
            return;
         }
         if(event.target != _growHelpTipView.viewBg)
         {
            stage.removeEventListener("click",__closeChairChnnel);
            if(_growHelpTipView)
            {
               _growHelpTipView.visible = false;
               _helpViewShow = true;
            }
         }
      }
      
      override public function dispose() : void
      {
         if(_growHelpBtn)
         {
            _growHelpBtn.dispose();
            _growHelpBtn = null;
         }
         if(_growHelpTipView)
         {
            _growHelpTipView.dispose();
            _growHelpTipView = null;
         }
         super.dispose();
      }
   }
}
