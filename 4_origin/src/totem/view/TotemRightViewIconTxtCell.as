package totem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   
   public class TotemRightViewIconTxtCell extends Sprite implements Disposeable
   {
       
      
      private var _iconComponent:Component;
      
      private var _icon:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _lineSp:Sprite;
      
      public function TotemRightViewIconTxtCell()
      {
         super();
         _txt = ComponentFactory.Instance.creatComponentByStylename("totem.rightView.iconCell.txt");
         _lineSp = new Sprite();
         _lineSp.x = _txt.x;
         _lineSp.y = _txt.y;
         _iconComponent = ComponentFactory.Instance.creatComponentByStylename("totem.rightView.iconComponent");
      }
      
      public function show(param1:int) : void
      {
         if(param1 == 1)
         {
            _icon = ComponentFactory.Instance.creatBitmap("asset.totem.rightView.exp");
            _iconComponent.tipStyle = null;
            ShowTipManager.Instance.removeTip(_iconComponent);
         }
         else
         {
            _icon = ComponentFactory.Instance.creatBitmap("asset.totem.rightView.honor");
            _txt.y = _txt.y + 6;
            _iconComponent.tipData = LanguageMgr.GetTranslation("ddt.totem.rightView.honorTipTxt");
         }
         _iconComponent.addChild(_icon);
         addChild(_iconComponent);
         addChild(_txt);
         addChild(_lineSp);
      }
      
      public function refresh(param1:int, param2:Boolean = false) : void
      {
         _txt.text = param1.toString();
         if(param2)
         {
            _txt.setTextFormat(new TextFormat(null,null,16711680));
         }
      }
      
      public function rawTextLine() : void
      {
         _lineSp.graphics.lineStyle(2,16711680);
         _lineSp.graphics.moveTo(0,_txt.height / 2);
         _lineSp.graphics.lineTo(_txt.textWidth + 5,_txt.height / 2);
         _lineSp.graphics.endFill();
      }
      
      public function clearTextLine() : void
      {
         _lineSp.graphics.clear();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _lineSp = null;
         _iconComponent = null;
         _icon = null;
         _txt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
