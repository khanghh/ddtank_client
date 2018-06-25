package sevenDouble.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import sevenDouble.SevenDoubleManager;
   import sevenDouble.event.SevenDoubleEvent;
   
   public class SevenDoubleRankView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _moveInBtn:SimpleBitmapButton;
      
      private var _moveOutBtn:SimpleBitmapButton;
      
      private var _rankTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _rateTxt:FilterFrameText;
      
      private var _sprintTxt:FilterFrameText;
      
      private var _rankCellList:Vector.<SevenDoubleRankCell>;
      
      public function SevenDoubleRankView()
      {
         super();
         this.x = 787;
         this.y = -3;
         initView();
         initEvent();
         setInOutVisible(true);
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var tmpCell:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.sevenDouble.rankViewBg");
         _moveOutBtn = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.rankViewMoveOutBtn");
         _moveInBtn = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.rankViewMoveInBtn");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.rankView.titleTxt");
         _rankTxt.text = LanguageMgr.GetTranslation("sevenDouble.rankView.rankTitleTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.rankView.titleTxt");
         _nameTxt.text = LanguageMgr.GetTranslation("sevenDouble.rankView.nameTitleTxt");
         PositionUtils.setPos(_nameTxt,"sevenDouble.rankView.nameTitleTxtPos");
         _rateTxt = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.rankView.titleTxt");
         _rateTxt.text = LanguageMgr.GetTranslation("sevenDouble.rankView.rateTitleTxt");
         PositionUtils.setPos(_rateTxt,"sevenDouble.rankView.rateTitleTxtPos");
         _sprintTxt = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.rankView.titleTxt");
         _sprintTxt.text = LanguageMgr.GetTranslation("sevenDouble.rankView.sprintTitleTxt");
         PositionUtils.setPos(_sprintTxt,"sevenDouble.rankView.sprintTitleTxtPos");
         addChild(_bg);
         addChild(_moveOutBtn);
         addChild(_moveInBtn);
         addChild(_rankTxt);
         addChild(_nameTxt);
         addChild(_rateTxt);
         addChild(_sprintTxt);
         _rankCellList = new Vector.<SevenDoubleRankCell>();
         for(i = 0; i < 5; )
         {
            tmpCell = new SevenDoubleRankCell(i);
            tmpCell.x = 17;
            tmpCell.y = 63 + i * 28;
            addChild(tmpCell);
            _rankCellList.push(tmpCell);
            i++;
         }
      }
      
      private function initEvent() : void
      {
         _moveOutBtn.addEventListener("click",outHandler,false,0,true);
         _moveInBtn.addEventListener("click",inHandler,false,0,true);
         SevenDoubleManager.instance.addEventListener("sevenDoubleRankList",refreshRankList);
      }
      
      private function outHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         setInOutVisible(false);
         TweenLite.to(this,0.5,{"x":1000});
      }
      
      private function setInOutVisible(isOut:Boolean) : void
      {
         _moveOutBtn.visible = isOut;
         _moveInBtn.visible = !isOut;
      }
      
      private function inHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         setInOutVisible(true);
         TweenLite.to(this,0.5,{"x":787});
      }
      
      private function refreshRankList(event:SevenDoubleEvent) : void
      {
         var i:int = 0;
         var rankInfoList:Array = event.data as Array;
         var len:int = rankInfoList.length;
         for(i = 0; i < len; )
         {
            _rankCellList[i].setName(rankInfoList[i].name,rankInfoList[i].carType);
            i++;
         }
      }
      
      private function removeEvent() : void
      {
         _moveOutBtn.removeEventListener("click",outHandler);
         _moveInBtn.removeEventListener("click",inHandler);
         SevenDoubleManager.instance.removeEventListener("sevenDoubleRankList",refreshRankList);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _moveInBtn = null;
         _moveOutBtn = null;
         _rankTxt = null;
         _nameTxt = null;
         _rateTxt = null;
         _sprintTxt = null;
         _rankCellList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
