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
      
      public function initView(userName:String, goodsName:String, url:String, number:int) : void
      {
         var line1:Bitmap = ComponentFactory.Instance.creatBitmap("asset.corel.formLineBig");
         line1.x = 118;
         line1.y = 1;
         var line2:Bitmap = ComponentFactory.Instance.creatBitmap("asset.corel.formLineBig");
         line2.x = 283;
         line2.y = 1;
         _bg = ComponentFactory.Instance.creat("caddy.badLuck.paihangItemBG");
         _bg.setFrame(number % 2 + 1);
         _bg.width = 580;
         _bg.height = 31;
         addChild(_bg);
         if(number > 3)
         {
            _bitMapTxt = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.numbTxt");
            _bitMapTxt.x = 47;
            _bitMapTxt.y = 6;
            _bitMapTxt.text = number + "th";
            addChild(_bitMapTxt);
            _bitMapTxt.visible = false;
         }
         else
         {
            _bitMap = ComponentFactory.Instance.creatBitmap("asset.awardSystem.th" + number);
            _bitMap.x = 37;
            _bitMap.y = 2;
            addChild(_bitMap);
            _bitMap.visible = false;
         }
         _userNameTxt = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.userNameTxt");
         _userNameTxt.x = 163;
         _userNameTxt.y = 5;
         _userNameTxt.text = userName;
         addChild(_userNameTxt);
         _userNameTxt.visible = false;
         _goodsNameTxt = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.goodsNametxt");
         _goodsNameTxt.text = goodsName;
         _goodsNameTxt.x = 290;
         _goodsNameTxt.y = 5;
         addChild(_goodsNameTxt);
         _goodsNameTxt.visible = false;
         addChild(line1);
         addChild(line2);
      }
      
      public function upDataUserName(obj:Object) : void
      {
         var info:* = null;
         var text:* = null;
         var tempList:* = null;
         var info1:* = null;
         var textList:* = null;
         var i:int = 0;
         var cell:* = null;
         var count:* = null;
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
            if(obj["Nickname"])
            {
               _userNameTxt.text = obj["Nickname"];
            }
            info = getItemInfoById(obj["TemplateID"]);
            if(info)
            {
               info.IsUsed = false;
               tempList = [];
               if(obj["TemplateID1"])
               {
                  info1 = getItemInfoById(obj["TemplateID1"]);
               }
               tempList.push(info);
               if(info1)
               {
                  info1.IsUsed = false;
                  if(info1.CategoryID == 24)
                  {
                     tempList.unshift(info1);
                  }
                  else
                  {
                     tempList.push(info1);
                  }
               }
               textList = [];
               for(i = 0; i < tempList.length; )
               {
                  cell = new PersonalInfoCell();
                  cell.info = tempList[i];
                  cell.x = 508 + i * 25;
                  cell.y = 5;
                  cell.tipGapH = -10;
                  cell.tipGapV = -40;
                  var _loc10_:* = 0.5;
                  cell.scaleY = _loc10_;
                  cell.scaleX = _loc10_;
                  if(cell.info.CategoryID == 24)
                  {
                     textList.push(cell.info.Name);
                  }
                  else
                  {
                     if(int(obj["count"]) > 1)
                     {
                        count = "x" + obj["count"];
                     }
                     else
                     {
                        count = "";
                     }
                     textList.push(cell.info.Name + count);
                  }
                  addChild(cell);
                  i++;
               }
               text = textList.join(",");
               _goodsNameTxt.text = text;
            }
         }
      }
      
      private function getItemInfoById(id:int) : InventoryItemInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = RouletteManager.instance.goodList;
         for each(var item in RouletteManager.instance.goodList)
         {
            if(item.TemplateID == id)
            {
               return item;
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
