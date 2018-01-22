package consortionBattle.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   
   public class ConsBatLosingStreakBuff extends Component
   {
       
      
      private var _icon:Bitmap;
      
      private var _countTxt:FilterFrameText;
      
      public function ConsBatLosingStreakBuff()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatBitmap("asset.game.losingStreakIcon");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("gameView.losingStreakCountTxt");
         _countTxt.text = "1";
         addChild(_icon);
         addChild(_countTxt);
         tipData = LanguageMgr.GetTranslation("ddt.game.consBat.losingStreakBuffTip",30);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _icon = null;
         _countTxt = null;
         super.dispose();
      }
   }
}
