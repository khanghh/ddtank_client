package lotteryTicket.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import lotteryTicket.LotteryManager;
   
   public class LotteryPrizeView extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _firstInfoTxt:FilterFrameText;
      
      private var _secondInfoTxt:FilterFrameText;
      
      private var _thirdInfoTxt:FilterFrameText;
      
      private var _fourthInfoTxt:FilterFrameText;
      
      private var scrollPanel:ScrollPanel;
      
      public function LotteryPrizeView()
      {
         var i:int = 0;
         var item:* = null;
         super();
         _bg = ComponentFactory.Instance.creatBitmap("asset.lotteryTicket.bg1");
         addToContent(_bg);
         _firstInfoTxt = ComponentFactory.Instance.creatComponentByStylename("asset.lotteryTicket.prizeList.txt");
         addToContent(_firstInfoTxt);
         _firstInfoTxt.htmlText = LanguageMgr.GetTranslation("asset.lotteryTicket.prizeInfo",LotteryManager.instance.model.firstCount,LotteryManager.instance.model.firstMoney);
         PositionUtils.setPos(_firstInfoTxt,"asset.lotteryTicket.prizeInfo.pos1");
         _secondInfoTxt = ComponentFactory.Instance.creatComponentByStylename("asset.lotteryTicket.prizeList.txt");
         addToContent(_secondInfoTxt);
         _secondInfoTxt.htmlText = LanguageMgr.GetTranslation("asset.lotteryTicket.prizeInfo",LotteryManager.instance.model.secondCount,LotteryManager.instance.model.secondMoney);
         PositionUtils.setPos(_secondInfoTxt,"asset.lotteryTicket.prizeInfo.pos2");
         _thirdInfoTxt = ComponentFactory.Instance.creatComponentByStylename("asset.lotteryTicket.prizeList.txt");
         addToContent(_thirdInfoTxt);
         _thirdInfoTxt.htmlText = LanguageMgr.GetTranslation("asset.lotteryTicket.prizeInfo",LotteryManager.instance.model.thirdCount,LotteryManager.instance.model.thirdMoney);
         PositionUtils.setPos(_thirdInfoTxt,"asset.lotteryTicket.prizeInfo.pos3");
         _fourthInfoTxt = ComponentFactory.Instance.creatComponentByStylename("asset.lotteryTicket.prizeList.txt");
         addToContent(_fourthInfoTxt);
         _fourthInfoTxt.htmlText = LanguageMgr.GetTranslation("asset.lotteryTicket.prizeInfo",LotteryManager.instance.model.fourthCount,LotteryManager.instance.model.fourthMoney);
         PositionUtils.setPos(_fourthInfoTxt,"asset.lotteryTicket.prizeInfo.pos4");
         var sprite:Sprite = new Sprite();
         for(i = 0; i < LotteryManager.instance.model.firstPlayerInfo.length; )
         {
            item = new PrizeItem(i);
            sprite.addChild(item);
            item.y = i * 37;
            i++;
         }
         scrollPanel = ComponentFactory.Instance.creatComponentByStylename("lotteryTicket.prizeList");
         scrollPanel.setView(sprite);
         addToContent(scrollPanel);
         addEventListener("response",_responseHandle);
      }
      
      protected function _responseHandle(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
               break;
            default:
               dispose();
               break;
            default:
               dispose();
               break;
            case 4:
         }
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",_responseHandle);
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_firstInfoTxt)
         {
            ObjectUtils.disposeObject(_firstInfoTxt);
         }
         _firstInfoTxt = null;
         if(_secondInfoTxt)
         {
            ObjectUtils.disposeObject(_secondInfoTxt);
         }
         _secondInfoTxt = null;
         if(_thirdInfoTxt)
         {
            ObjectUtils.disposeObject(_thirdInfoTxt);
         }
         _thirdInfoTxt = null;
         if(_fourthInfoTxt)
         {
            ObjectUtils.disposeObject(_fourthInfoTxt);
         }
         _fourthInfoTxt = null;
         if(scrollPanel)
         {
            ObjectUtils.disposeObject(scrollPanel);
         }
         scrollPanel = null;
         super.dispose();
      }
   }
}

import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.text.FilterFrameText;
import ddt.utils.PositionUtils;
import ddt.view.common.LevelIcon;
import flash.display.Bitmap;
import flash.display.Sprite;
import lotteryTicket.LotteryManager;

class PrizeItem extends Sprite
{
    
   
   private var bg:Bitmap;
   
   private var _zoneTxt:FilterFrameText;
   
   private var _nameTxt:FilterFrameText;
   
   private var level:LevelIcon;
   
   function PrizeItem(index:int)
   {
      super();
      if(index % 2 == 0)
      {
         bg = ComponentFactory.Instance.creatBitmap("asset.lotteryTicket.list1");
      }
      else
      {
         bg = ComponentFactory.Instance.creatBitmap("asset.lotteryTicket.list2");
      }
      addChild(bg);
      _zoneTxt = ComponentFactory.Instance.creatComponentByStylename("asset.lotteryTicket.prizeListInfo.txt");
      addChild(_zoneTxt);
      _zoneTxt.width = 110;
      _zoneTxt.text = LotteryManager.instance.model.firstPlayerInfo[index].split("-")[0];
      PositionUtils.setPos(_zoneTxt,"asset.lotteryTicket.prizeZone.pos");
      _nameTxt = ComponentFactory.Instance.creatComponentByStylename("asset.lotteryTicket.prizeListInfo.txt");
      addChild(_nameTxt);
      _nameTxt.width = 183;
      _nameTxt.text = LotteryManager.instance.model.firstPlayerInfo[index].split("-")[1];
      PositionUtils.setPos(_nameTxt,"asset.lotteryTicket.prizeName.pos");
      level = new LevelIcon();
      PositionUtils.setPos(level,"asset.lotteryTicket.levelIcon.pos");
      level.setInfo(parseInt(LotteryManager.instance.model.firstPlayerInfo[index].split("-")[2]),0,0,0,0,0,0,false,false);
      addChild(level);
   }
}
