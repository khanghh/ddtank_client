package worldboss.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import worldboss.WorldBossManager;
   
   public class WorldBossBuffItem extends Sprite implements Disposeable
   {
       
      
      private var _icon:Bitmap;
      
      private var _iconSprite:Sprite;
      
      private var _levelTxt:FilterFrameText;
      
      private var _tipBg:ScaleBitmapImage;
      
      private var _tipTitleTxt:FilterFrameText;
      
      private var _tipDescTxt:FilterFrameText;
      
      public function WorldBossBuffItem()
      {
         super();
         initView();
         updateInfo();
         addEvent();
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatBitmap("worldBoss.attackBuff");
         _iconSprite = new Sprite();
         _iconSprite.addChild(_icon);
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("worldBossRoom.buff.levelTxt");
         _tipBg = ComponentFactory.Instance.creatComponentByStylename("worldBossRoom.newBuff.tipTxtBG");
         _tipTitleTxt = ComponentFactory.Instance.creatComponentByStylename("worldBossRoom.buff.tipTxt.title");
         _tipDescTxt = ComponentFactory.Instance.creatComponentByStylename("worldBossRoom.buff.tipTxt.desc");
         hideTip(null);
         addChild(_iconSprite);
         addChild(_levelTxt);
         addChild(_tipBg);
         addChild(_tipTitleTxt);
         addChild(_tipDescTxt);
      }
      
      public function updateInfo() : void
      {
         var tmpLevel:int = WorldBossManager.Instance.bossInfo.myPlayerVO.buffLevel;
         _levelTxt.text = tmpLevel.toString();
         var tmpEnhanceValue:int = WorldBossManager.Instance.bossInfo.myPlayerVO.buffInjure;
         _tipTitleTxt.text = LanguageMgr.GetTranslation("worldboss.buffIcon.tip.title",tmpEnhanceValue);
         _tipDescTxt.text = LanguageMgr.GetTranslation("worldboss.buffIcon.tip.desc",tmpEnhanceValue);
         this.visible = tmpLevel != 0?true:false;
      }
      
      private function addEvent() : void
      {
         _iconSprite.addEventListener("mouseOver",showTip);
         _iconSprite.addEventListener("mouseOut",hideTip);
         WorldBossManager.Instance.addEventListener("change",__update);
      }
      
      protected function __update(event:Event) : void
      {
         updateInfo();
      }
      
      private function showTip(event:MouseEvent) : void
      {
         _tipBg.visible = true;
         _tipTitleTxt.visible = true;
         _tipDescTxt.visible = true;
      }
      
      private function hideTip(event:MouseEvent) : void
      {
         _tipBg.visible = false;
         _tipTitleTxt.visible = false;
         _tipDescTxt.visible = false;
      }
      
      private function removeEvent() : void
      {
         _iconSprite.removeEventListener("mouseOver",showTip);
         _iconSprite.removeEventListener("mouseOut",hideTip);
         WorldBossManager.Instance.removeEventListener("change",__update);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            this.parent.removeChild(this);
         }
         _icon = null;
         _levelTxt = null;
         _tipBg = null;
         _tipTitleTxt = null;
         _tipDescTxt = null;
      }
   }
}
