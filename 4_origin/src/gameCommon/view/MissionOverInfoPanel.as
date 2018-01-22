package gameCommon.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class MissionOverInfoPanel extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      public var titleTxt1:FilterFrameText;
      
      public var titleTxt2:FilterFrameText;
      
      public var titleTxt3:FilterFrameText;
      
      public var valueTxt1:FilterFrameText;
      
      public var valueTxt2:FilterFrameText;
      
      public var valueTxt3:FilterFrameText;
      
      public function MissionOverInfoPanel()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.game.missionOverInfoPanelAsset");
         addChild(_bg);
         titleTxt1 = ComponentFactory.Instance.creatComponentByStylename("asset.game.missionOverInfoTitle1Txt");
         addChild(titleTxt1);
         titleTxt2 = ComponentFactory.Instance.creatComponentByStylename("asset.game.missionOverInfoTitle2Txt");
         addChild(titleTxt2);
         titleTxt3 = ComponentFactory.Instance.creatComponentByStylename("asset.game.missionOverInfoTitle3Txt");
         addChild(titleTxt3);
         valueTxt1 = ComponentFactory.Instance.creatComponentByStylename("asset.game.missionOverInfo1Txt");
         addChild(valueTxt1);
         valueTxt2 = ComponentFactory.Instance.creatComponentByStylename("asset.game.missionOverInfo2Txt");
         addChild(valueTxt2);
         valueTxt3 = ComponentFactory.Instance.creatComponentByStylename("asset.game.missionOverInfo3Txt");
         addChild(valueTxt3);
      }
      
      public function dispose() : void
      {
         removeChild(_bg);
         _bg.bitmapData.dispose();
         _bg = null;
         titleTxt1.dispose();
         titleTxt1 = null;
         titleTxt2.dispose();
         titleTxt2 = null;
         titleTxt3.dispose();
         titleTxt3 = null;
         valueTxt1.dispose();
         valueTxt1 = null;
         valueTxt2.dispose();
         valueTxt2 = null;
         valueTxt3.dispose();
         valueTxt3 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
