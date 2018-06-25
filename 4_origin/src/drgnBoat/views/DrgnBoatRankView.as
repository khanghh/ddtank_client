package drgnBoat.views
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
   import drgnBoat.DrgnBoatManager;
   import drgnBoat.event.DrgnBoatEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class DrgnBoatRankView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _moveInBtn:SimpleBitmapButton;
      
      private var _moveOutBtn:SimpleBitmapButton;
      
      private var _rankTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _rateTxt:FilterFrameText;
      
      private var _rankCellList:Vector.<DrgnBoatRankCell>;
      
      public function DrgnBoatRankView()
      {
         super();
         this.x = 756;
         this.y = -3;
         initView();
         initEvent();
         setInOutVisible(true);
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var tmpCell:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("drgnBoat.rankViewBg");
         _moveOutBtn = ComponentFactory.Instance.creatComponentByStylename("drgnBoat.rankViewMoveOutBtn");
         _moveInBtn = ComponentFactory.Instance.creatComponentByStylename("drgnBoat.rankViewMoveInBtn");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("drgnBoat.rankView.titleTxt");
         _rankTxt.text = LanguageMgr.GetTranslation("escort.rankView.rankTitleTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("drgnBoat.rankView.titleTxt");
         _nameTxt.text = LanguageMgr.GetTranslation("escort.rankView.nameTitleTxt");
         PositionUtils.setPos(_nameTxt,"drgnBoat.rankView.nameTitleTxtPos");
         _rateTxt = ComponentFactory.Instance.creatComponentByStylename("drgnBoat.rankView.titleTxt");
         _rateTxt.text = LanguageMgr.GetTranslation("drgnBoat.rankView.rateTitleTxt");
         PositionUtils.setPos(_rateTxt,"drgnBoat.rankView.rateTitleTxtPos");
         addChild(_bg);
         addChild(_moveOutBtn);
         addChild(_moveInBtn);
         addChild(_rankTxt);
         addChild(_nameTxt);
         addChild(_rateTxt);
         _rankCellList = new Vector.<DrgnBoatRankCell>();
         for(i = 0; i < 5; )
         {
            tmpCell = new DrgnBoatRankCell(i);
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
         DrgnBoatManager.instance.addEventListener("drgnBoatRankList",refreshRankList);
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
         TweenLite.to(this,0.5,{"x":756});
      }
      
      private function refreshRankList(event:DrgnBoatEvent) : void
      {
         var i:int = 0;
         var rankInfoList:Array = event.data as Array;
         var len:int = rankInfoList.length;
         for(i = 0; i < len; )
         {
            _rankCellList[i].setName(rankInfoList[i].name,rankInfoList[i].carType,rankInfoList[i].isSelf);
            i++;
         }
      }
      
      private function removeEvent() : void
      {
         _moveOutBtn.removeEventListener("click",outHandler);
         _moveInBtn.removeEventListener("click",inHandler);
         DrgnBoatManager.instance.removeEventListener("drgnBoatRankList",refreshRankList);
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
         _rankCellList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
