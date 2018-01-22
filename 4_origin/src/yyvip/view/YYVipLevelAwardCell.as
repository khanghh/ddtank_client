package yyvip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import yyvip.YYVipControl;
   
   public class YYVipLevelAwardCell extends Sprite implements Disposeable
   {
       
      
      private var _icon:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _itemList:Vector.<YYVipLevelAwardItemCell>;
      
      public function YYVipLevelAwardCell(param1:int)
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         super();
         _icon = ComponentFactory.Instance.creatBitmap("asset.yyvip.levelIcon" + param1);
         _txt = ComponentFactory.Instance.creatComponentByStylename("yyvip.levelAwardCell.tipTxt");
         _txt.text = LanguageMgr.GetTranslation("yyVip.dailyView.levelAwardCell.tipTxt",param1);
         addChild(_icon);
         addChild(_txt);
         _itemList = new Vector.<YYVipLevelAwardItemCell>();
         var _loc3_:Vector.<Object> = YYVipControl.instance.getDailyLevelVipAwardList(param1);
         var _loc4_:int = _loc3_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = new YYVipLevelAwardItemCell(_loc3_[_loc5_]);
            _loc2_.x = 170 + _loc5_ * 108;
            _loc2_.y = -1;
            addChild(_loc2_);
            _itemList.push(_loc2_);
            _loc5_++;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _icon = null;
         _txt = null;
         _itemList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
