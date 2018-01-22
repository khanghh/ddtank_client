package ddt.view.caddyII.items
{
   import bagAndInfo.cell.PersonalInfoCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.RouletteManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class AwardListItem extends Sprite implements Disposeable
   {
       
      
      private var _userNameTxt:FilterFrameText;
      
      private var _goodsNameTxt:FilterFrameText;
      
      private var _bitMapTxt:FilterFrameText;
      
      private var _bitMap:Bitmap;
      
      private var _content:Sprite;
      
      private var _bg:ScaleFrameImage;
      
      public function AwardListItem()
      {
         super();
      }
      
      public function initView(param1:String, param2:String, param3:String, param4:int) : void
      {
         var _loc5_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.corel.formLineBig");
         _loc5_.x = 118;
         _loc5_.y = 1;
         var _loc6_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.corel.formLineBig");
         _loc6_.x = 283;
         _loc6_.y = 1;
         _bg = ComponentFactory.Instance.creat("caddy.badLuck.paihangItemBG");
         _bg.setFrame(param4 % 2 + 1);
         _bg.width = 580;
         _bg.height = 31;
         addChild(_bg);
         if(param4 > 3)
         {
            _bitMapTxt = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.numbTxt");
            _bitMapTxt.x = 47;
            _bitMapTxt.y = 6;
            _bitMapTxt.text = param4 + "th";
            addChild(_bitMapTxt);
            _bitMapTxt.visible = false;
         }
         else
         {
            _bitMap = ComponentFactory.Instance.creatBitmap("asset.awardSystem.th" + param4);
            _bitMap.x = 37;
            _bitMap.y = 2;
            addChild(_bitMap);
            _bitMap.visible = false;
         }
         _userNameTxt = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.userNameTxt");
         _userNameTxt.x = 163;
         _userNameTxt.y = 5;
         _userNameTxt.text = param1;
         addChild(_userNameTxt);
         _userNameTxt.visible = false;
         _goodsNameTxt = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.goodsNametxt");
         _goodsNameTxt.text = param2;
         _goodsNameTxt.x = 290;
         _goodsNameTxt.y = 5;
         addChild(_goodsNameTxt);
         _goodsNameTxt.visible = false;
         addChild(_loc5_);
         addChild(_loc6_);
      }
      
      public function upDataUserName(param1:Object) : void
      {
         var _loc9_:* = null;
         var _loc2_:* = null;
         var _loc8_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(_userNameTxt)
         {
            if(_bitMapTxt)
            {
               _bitMapTxt.visible = true;
            }
            if(_bitMap)
            {
               _bitMap.visible = true;
            }
            _userNameTxt.visible = true;
            _goodsNameTxt.visible = true;
            if(param1["Nickname"])
            {
               _userNameTxt.text = param1["Nickname"];
            }
            _loc9_ = getItemInfoById(param1["TemplateID"]);
            if(_loc9_)
            {
               _loc9_.IsUsed = false;
               _loc8_ = [];
               if(param1["TemplateID1"])
               {
                  _loc5_ = getItemInfoById(param1["TemplateID1"]);
               }
               _loc8_.push(_loc9_);
               if(_loc5_)
               {
                  _loc5_.IsUsed = false;
                  if(_loc5_.CategoryID == 24)
                  {
                     _loc8_.unshift(_loc5_);
                  }
                  else
                  {
                     _loc8_.push(_loc5_);
                  }
               }
               _loc6_ = [];
               _loc7_ = 0;
               while(_loc7_ < _loc8_.length)
               {
                  _loc4_ = new PersonalInfoCell();
                  _loc4_.info = _loc8_[_loc7_];
                  _loc4_.x = 508 + _loc7_ * 25;
                  _loc4_.y = 5;
                  _loc4_.tipGapH = -10;
                  _loc4_.tipGapV = -40;
                  var _loc10_:* = 0.5;
                  _loc4_.scaleY = _loc10_;
                  _loc4_.scaleX = _loc10_;
                  if(_loc4_.info.CategoryID == 24)
                  {
                     _loc6_.push(_loc4_.info.Name);
                  }
                  else
                  {
                     if(int(param1["count"]) > 1)
                     {
                        _loc3_ = "x" + param1["count"];
                     }
                     else
                     {
                        _loc3_ = "";
                     }
                     _loc6_.push(_loc4_.info.Name + _loc3_);
                  }
                  addChild(_loc4_);
                  _loc7_++;
               }
               _loc2_ = _loc6_.join(",");
               _goodsNameTxt.text = _loc2_;
            }
         }
      }
      
      private function getItemInfoById(param1:int) : InventoryItemInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = RouletteManager.instance.goodList;
         for each(var _loc2_ in RouletteManager.instance.goodList)
         {
            if(_loc2_.TemplateID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _userNameTxt = null;
         _goodsNameTxt = null;
         _bitMapTxt = null;
         _content = null;
         _bitMap = null;
         _bg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
