package totem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import totem.TotemManager;
   
   public class TotemInfoView extends Sprite implements Disposeable
   {
       
      
      private var _windowView:TotemLeftWindowView;
      
      private var _levelBg:Bitmap;
      
      private var _level:FilterFrameText;
      
      private var _txtBg:Bitmap;
      
      private var _propertyList:Vector.<TotemInfoViewTxtCell>;
      
      private var _info:PlayerInfo;
      
      public function TotemInfoView(param1:PlayerInfo)
      {
         super();
         _info = param1;
         initView();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _windowView = ComponentFactory.Instance.creatCustomObject("totemInfoWindowView");
         _windowView.show(TotemManager.instance.getCurInfoById(_info.totemId).Page,TotemManager.instance.getNextInfoById(_info.totemId),false);
         _windowView.scaleX = 0.792349726775956;
         _windowView.scaleY = 0.792349726775956;
         _windowView.scalePropertyTxtSprite(1.26206896551724);
         _levelBg = ComponentFactory.Instance.creatBitmap("asset.totem.infoView.levelBg");
         _level = ComponentFactory.Instance.creatComponentByStylename("totem.infoView.level.txt");
         _txtBg = ComponentFactory.Instance.creatBitmap("asset.totem.infoView.txtBg");
         addChild(_windowView);
         addChild(_levelBg);
         addChild(_level);
         _level.text = TotemManager.instance.getCurrentLv(TotemManager.instance.getTotemPointLevel(_info.totemId)).toString();
         addChild(_txtBg);
         _propertyList = new Vector.<TotemInfoViewTxtCell>();
         _loc2_ = 1;
         while(_loc2_ <= 7)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("TotemInfoViewTxtCell" + _loc2_);
            _loc1_.show(_loc2_,TotemManager.instance.getTotemPointLevel(_info.totemId));
            addChild(_loc1_);
            _propertyList.push(_loc1_);
            _loc1_.x = _propertyList[0].x + (_loc2_ - 1) % 4 * 104;
            _loc1_.y = _propertyList[0].y + int((_loc2_ - 1) / 4) * 32;
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _windowView = null;
         _levelBg = null;
         _level = null;
         _txtBg = null;
         _propertyList = null;
         _info = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
