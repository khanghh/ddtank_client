package firstRecharge.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.FTextButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LeavePageManager;
   import ddt.manager.SoundManager;
   import firstRecharge.items.PicItem;
   import firstRecharge.items.String8;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class AccumulationView extends Frame implements Disposeable
   {
       
      
      private var _treeImage:ScaleBitmapImage;
      
      private var _treeImage2:Scale9CornerImage;
      
      private var _pricePic:Bitmap;
      
      private var _picBack:Bitmap;
      
      private var _barBack:Bitmap;
      
      private var _libaoTxt:Bitmap;
      
      private var _daojishiTxt:Bitmap;
      
      private var _itemList:Vector.<PicItem>;
      
      private var _goodsContentList:Vector.<BagCell>;
      
      private var _selcetedBitMap:Bitmap;
      
      private var _iconStrList:Array;
      
      private var _iconTxtStrList:Array;
      
      private var _txt1:FilterFrameText;
      
      private var _txt2:FilterFrameText;
      
      private var _txt3:FilterFrameText;
      
      private var _txt4:FilterFrameText;
      
      private var _txt5:FilterFrameText;
      
      private var _txt6:FilterFrameText;
      
      private var _txt7:FilterFrameText;
      
      private var _btn:FTextButton;
      
      private var _fengeLine:Bitmap;
      
      private var _goldLine:Bitmap;
      
      private var str8:String8;
      
      public function AccumulationView()
      {
         _iconStrList = ["fristRecharge.level1","fristRecharge.level2","fristRecharge.level3","fristRecharge.level4","fristRecharge.level5","fristRecharge.level6"];
         _iconTxtStrList = ["充值500点券","充值1000点券","充值2000点券","充值5000点券","充值10000点券","充值50000点券"];
         super();
         initView();
         initEvent();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",_response);
         addEventListener("click",mouseClickHander);
      }
      
      private function uinitEvent() : void
      {
         removeEventListener("response",_response);
         removeEventListener("click",mouseClickHander);
         _btn.removeEventListener("click",clickHander);
      }
      
      protected function _response(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            ObjectUtils.disposeObject(this);
         }
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var item:* = null;
         var j:int = 0;
         var gItem:* = null;
         _itemList = new Vector.<PicItem>();
         _goodsContentList = new Vector.<BagCell>();
         _treeImage = ComponentFactory.Instance.creatComponentByStylename("accumulationView.scale9cornerImageTree");
         addToContent(_treeImage);
         _treeImage2 = ComponentFactory.Instance.creatComponentByStylename("accumulationView.scale9cornerImageTree2");
         addToContent(_treeImage2);
         _picBack = ComponentFactory.Instance.creatBitmap("fristRecharge.pic.back");
         addToContent(_picBack);
         _barBack = ComponentFactory.Instance.creatBitmap("fristRecharge.bar.back");
         addToContent(_barBack);
         _libaoTxt = ComponentFactory.Instance.creatBitmap("fristRecharge.libao.giftList");
         addToContent(_libaoTxt);
         _pricePic = ComponentFactory.Instance.creatBitmap("fristRecharge.libao.price");
         addToContent(_pricePic);
         _daojishiTxt = ComponentFactory.Instance.creatBitmap("fristRecharge.downtimes");
         addToContent(_daojishiTxt);
         _txt2 = ComponentFactory.Instance.creatComponentByStylename("firstrecharge.txt2");
         _txt2.text = "还要充值                 点券，您就能领取价值              点卷的礼包了！";
         addToContent(_txt2);
         _txt4 = ComponentFactory.Instance.creatComponentByStylename("firstrecharge.txt4");
         _txt4.text = "倒计时天数";
         addToContent(_txt4);
         _txt6 = ComponentFactory.Instance.creatComponentByStylename("firstrecharge.txt6");
         _txt6.text = "500";
         addToContent(_txt6);
         _txt7 = ComponentFactory.Instance.creatComponentByStylename("firstrecharge.txt7");
         _txt7.text = "8888";
         addToContent(_txt7);
         str8 = new String8();
         str8.setNum("1234");
         addToContent(str8);
         titleText = "充值奖励";
         for(i = 0; i < 6; )
         {
            item = new PicItem();
            if(i == 0)
            {
               item.x = 25;
            }
            else
            {
               item.x = i * (item.width + 1) + 40;
            }
            item.y = 57;
            item.id = i;
            item.setTxtStr(_iconTxtStrList[i]);
            item.addIcon(_iconStrList[i]);
            addToContent(item);
            _itemList.push(item);
            i++;
         }
         for(j = 0; j < 8; )
         {
            gItem = new BagCell(j);
            gItem.x = j * (gItem.width + 8) + 160;
            gItem.y = 233;
            addToContent(gItem);
            _goodsContentList.push(gItem);
            j++;
         }
         _selcetedBitMap = ComponentFactory.Instance.creatBitmap("fristRecharge.selected");
         addToContent(_selcetedBitMap);
         _btn = new FTextButton("accumulationView.ftxtBtn","firstrecharge.txt5");
         _btn.x = 300;
         _btn.y = 390;
         _btn.setTxt("前去充值");
         addToContent(_btn);
         _btn.addEventListener("click",clickHander);
         _fengeLine = ComponentFactory.Instance.creat("fristRecharge.libao.fengeLine");
         addToContent(_fengeLine);
         _goldLine = ComponentFactory.Instance.creat("fristRecharge.libao.gold");
         addToContent(_goldLine);
      }
      
      protected function clickHander(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         LeavePageManager.leaveToFillPath();
      }
      
      protected function mouseClickHander(event:MouseEvent) : void
      {
         if(event.target is PicItem)
         {
            var _loc2_:* = event.target.id;
            if(0 !== _loc2_)
            {
               if(1 !== _loc2_)
               {
                  if(2 !== _loc2_)
                  {
                     if(3 !== _loc2_)
                     {
                        if(4 !== _loc2_)
                        {
                           if(5 === _loc2_)
                           {
                              str8.setNum("8888");
                           }
                        }
                        else
                        {
                           str8.setNum("7288");
                        }
                     }
                     else
                     {
                        str8.setNum("5268");
                     }
                  }
                  else
                  {
                     str8.setNum("2298");
                  }
               }
               else
               {
                  str8.setNum("1788");
               }
            }
            else
            {
               str8.setNum("288");
            }
            _selcetedBitMap.x = event.target.x - 2;
            _selcetedBitMap.y = event.target.y - 4;
         }
      }
      
      override public function dispose() : void
      {
         uinitEvent();
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
      }
   }
}
