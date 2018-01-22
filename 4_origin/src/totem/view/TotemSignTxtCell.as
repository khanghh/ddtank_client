package totem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class TotemSignTxtCell extends Sprite implements Disposeable
   {
      
      public static const TOTEM_SIGN:int = 30000;
       
      
      private var _iconComponent:Component;
      
      private var _icon:Bitmap;
      
      private var _txt:FilterFrameText;
      
      public function TotemSignTxtCell()
      {
         super();
         _icon = ComponentFactory.Instance.creatBitmap("asset.totem.totemSignIcon");
         _iconComponent = ComponentFactory.Instance.creatCustomObject("totemSign.cellTipComponent");
         _iconComponent.tipData = LanguageMgr.GetTranslation("ddt.totem.rightViewTotemSignTipMsg");
         _iconComponent.addChild(_icon);
         addChild(_iconComponent);
         _txt = ComponentFactory.Instance.creatComponentByStylename("totem.rightView.totemSignTxtCelltotemTxt");
         addChild(_txt);
      }
      
      public function updateData() : void
      {
         var _loc1_:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(30000,true);
         _txt.text = _loc1_ + "";
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeAllChildren(_iconComponent);
         ObjectUtils.disposeObject(_iconComponent);
         _iconComponent = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
