package cityBattle.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.Helpers;
   import ddt.view.bossbox.AwardsGoodsList;
   import flash.events.MouseEvent;
   
   public class WinnerPrizeView extends Frame
   {
       
      
      private var _infoTxt:FilterFrameText;
      
      private var GoodsBG:ScaleBitmapImage;
      
      private var list:AwardsGoodsList;
      
      private var _goodsList:Array;
      
      private var _button:TextButton;
      
      public function WinnerPrizeView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("ddt.cityBattle.winnerPrize");
         _infoTxt = ComponentFactory.Instance.creatComponentByStylename("welfare.winnerPrizeInfo.txt");
         addChild(_infoTxt);
         GoodsBG = ComponentFactory.Instance.creat("welfare.prizeGoodsBg");
         addToContent(GoodsBG);
         _button = ComponentFactory.Instance.creat("welfare.okButton");
         _button.text = LanguageMgr.GetTranslation("ddt.cityBattle.welfare.okButton.ok");
         addToContent(_button);
         _button.addEventListener("click",_click);
         addEventListener("response",__frameEventHandler);
      }
      
      private function _click(evt:MouseEvent) : void
      {
         dispose();
      }
      
      public function set goodsList(templateIds:Array) : void
      {
         _goodsList = templateIds;
         list = ComponentFactory.Instance.creatCustomObject("welfare.winnerPrize.goodsList");
         list.show(_goodsList);
         addChild(list);
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               dispose();
         }
      }
      
      public function get goodsList() : Array
      {
         return Helpers.clone(_goodsList) as Array;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEventListener("response",__frameEventHandler);
         _button.removeEventListener("click",_click);
         ObjectUtils.disposeObject(_infoTxt);
         _infoTxt = null;
         ObjectUtils.disposeObject(GoodsBG);
         GoodsBG = null;
         ObjectUtils.disposeObject(_button);
         _button = null;
         if(list)
         {
            ObjectUtils.disposeObject(list);
         }
         list = null;
         super.dispose();
      }
   }
}
