package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class GuildIconTip extends Sprite implements ITip, Disposeable
   {
       
      
      private var _tipData:GuildIconTipInfo;
      
      private var _bg:ScaleBitmapImage;
      
      private var _guildLVTitle:Bitmap;
      
      private var _guildLV:Sprite;
      
      private var _stateTitle:Bitmap;
      
      private var _stateTxt:FilterFrameText;
      
      private var _repute:GuildRepute;
      
      public function GuildIconTip()
      {
         super();
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.guildIconTipBg");
         addChild(_bg);
         _guildLVTitle = ComponentFactory.Instance.creatBitmap("asset.core.guildLevelAsset");
         addChild(_guildLVTitle);
         _stateTitle = ComponentFactory.Instance.creatBitmap("asset.core.consortiaTip.StatePic");
         addChild(_stateTitle);
         _stateTxt = ComponentFactory.Instance.creatComponentByStylename("core.guildStateTxt");
         addChild(_stateTxt);
         _repute = ComponentFactory.Instance.creatCustomObject("asset.core.guildRepute");
         addChild(_repute);
      }
      
      public function get tipData() : Object
      {
         return _tipData;
      }
      
      public function set tipData(param1:Object) : void
      {
         if(param1)
         {
            _tipData = param1 as GuildIconTipInfo;
            if(_guildLV)
            {
               ObjectUtils.disposeAllChildren(_guildLV);
               ObjectUtils.disposeObject(_guildLV);
            }
            _guildLV = LevelPicCreater.creatLelvePic(_tipData.Level);
            PositionUtils.setPos(_guildLV,"asset.core.guildLevelPos");
            addChild(_guildLV);
            _repute.setRepute(_tipData.Repute);
            if(_tipData.State == 3)
            {
               _stateTxt.text = LanguageMgr.GetTranslation("tank.view.common.ConsortiaIcon.enemy");
               _stateTxt.textColor = 16718863;
            }
            else if(_tipData.State == 1)
            {
               _stateTxt.text = LanguageMgr.GetTranslation("tank.view.common.ConsortiaIcon.self");
               _stateTxt.textColor = 61183;
            }
            else
            {
               _stateTxt.text = LanguageMgr.GetTranslation("tank.view.common.ConsortiaIcon.middle");
               _stateTxt.textColor = 5898001;
            }
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(_guildLV);
         _guildLV = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
