package consortion.view.selfConsortia
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortiaApplyInfo;
   import consortion.event.ConsortionEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class TakeInMemberFrame extends Frame
   {
       
      
      private var _bg:MovieImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _levelTxt:FilterFrameText;
      
      private var _powerTxt:FilterFrameText;
      
      private var _operateTxt:FilterFrameText;
      
      private var _level:TextButton;
      
      private var _power:TextButton;
      
      private var _selectAll:TextButton;
      
      private var _agree:TextButton;
      
      private var _refuse:TextButton;
      
      private var _setRefuse:SelectedCheckButton;
      
      private var _refuseImg:FilterFrameText;
      
      private var _takeIn:TextButton;
      
      private var _close:TextButton;
      
      private var _list:VBox;
      
      private var _lastSort:String;
      
      private var _items:Array;
      
      private var _turnPage:TakeInTurnPage;
      
      private var _itemBG:MutipleImage;
      
      private var _menberListVLine:MutipleImage;
      
      private var _powerBtn:Sprite;
      
      private var _levelBtn:Sprite;
      
      private var _pageCount:int = 8;
      
      public function TakeInMemberFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         escEnable = true;
         disposeChildren = true;
         titleText = LanguageMgr.GetTranslation("tank.consortia.myconsortia.MyConsortiaAuditingApplyList.titleText");
         _bg = ComponentFactory.Instance.creatComponentByStylename("takeInMemberFrame.BG");
         _menberListVLine = ComponentFactory.Instance.creatComponentByStylename("consortion.takeInMemberListVLine");
         _itemBG = ComponentFactory.Instance.creatComponentByStylename("takeInMemberItem.BG");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.takeIn.nameTxt");
         _nameTxt.text = LanguageMgr.GetTranslation("itemview.listname");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.takeIn.levelTxt");
         _levelTxt.text = LanguageMgr.GetTranslation("itemview.listlevel");
         _powerTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.takeInItem.powerTxt");
         _powerTxt.text = LanguageMgr.GetTranslation("itemview.listfightpower");
         _operateTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.takeIn.operateTxt");
         _operateTxt.text = LanguageMgr.GetTranslation("operate");
         _selectAll = ComponentFactory.Instance.creatComponentByStylename("consortion.takeIn.selectAllBtn");
         _selectAll.text = LanguageMgr.GetTranslation("consortion.takeIn.selectAllBtn.text");
         _agree = ComponentFactory.Instance.creatComponentByStylename("consortion.takeIn.agreeBtn");
         _agree.text = LanguageMgr.GetTranslation("consortion.takeIn.agreeBtn.text");
         _refuse = ComponentFactory.Instance.creatComponentByStylename("consortion.takeIn.refuseBtn");
         _refuse.text = LanguageMgr.GetTranslation("consortion.takeIn.refuseBtn.text");
         _setRefuse = ComponentFactory.Instance.creatComponentByStylename("consortion.takeIn.setRefuse");
         _refuseImg = ComponentFactory.Instance.creatComponentByStylename("consortion.takeIn.setRefuseText");
         _refuseImg.text = LanguageMgr.GetTranslation("consortion.takeIn.setRefuseText.text");
         _takeIn = ComponentFactory.Instance.creatComponentByStylename("consortion.takeIn.takeIn");
         _close = ComponentFactory.Instance.creatComponentByStylename("consortion.takeIn.close");
         _list = ComponentFactory.Instance.creatComponentByStylename("consortion.takeIn.list");
         _turnPage = ComponentFactory.Instance.creatCustomObject("takeInTurnPage");
         _levelBtn = new Sprite();
         _levelBtn.graphics.beginFill(16777215,1);
         _levelBtn.graphics.drawRect(0,0,65,30);
         _levelBtn.graphics.endFill();
         _levelBtn.alpha = 0;
         _levelBtn.buttonMode = true;
         _levelBtn.mouseEnabled = true;
         _levelBtn.x = 165;
         _powerBtn = new Sprite();
         _powerBtn.graphics.beginFill(16777215,1);
         _powerBtn.graphics.drawRect(0,0,80,30);
         _powerBtn.graphics.endFill();
         _powerBtn.alpha = 0;
         _powerBtn.buttonMode = true;
         _powerBtn.mouseEnabled = true;
         _powerBtn.x = 232;
         var _loc1_:int = 45;
         _levelBtn.y = _loc1_;
         _powerBtn.y = _loc1_;
         addToContent(_bg);
         addToContent(_menberListVLine);
         addToContent(_itemBG);
         addToContent(_nameTxt);
         addToContent(_levelTxt);
         addToContent(_powerTxt);
         addToContent(_operateTxt);
         addToContent(_selectAll);
         addToContent(_agree);
         addToContent(_refuse);
         addToContent(_setRefuse);
         _setRefuse.addChild(_refuseImg);
         addToContent(_takeIn);
         addToContent(_close);
         addToContent(_list);
         addToContent(_turnPage);
         addToContent(_levelBtn);
         addToContent(_powerBtn);
         _takeIn.text = LanguageMgr.GetTranslation("tank.consortia.myconsortia.MyConsortiaAuditingApplyList.okLabel");
         _close.text = LanguageMgr.GetTranslation("tank.invite.InviteView.close");
         _setRefuse.visible = PlayerManager.Instance.Self.consortiaInfo.ChairmanID == PlayerManager.Instance.Self.ID?true:false;
         _setRefuse.selected = !PlayerManager.Instance.Self.consortiaInfo.OpenApply;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _levelBtn.addEventListener("click",__clickHandler);
         _powerBtn.addEventListener("click",__clickHandler);
         _selectAll.addEventListener("click",__clickHandler);
         _agree.addEventListener("click",__clickHandler);
         _refuse.addEventListener("click",__clickHandler);
         _setRefuse.addEventListener("click",__clickHandler);
         _takeIn.addEventListener("click",__clickHandler);
         _close.addEventListener("click",__clickHandler);
         _turnPage.addEventListener("pageChange",__pageChangeHandler);
         ConsortionModelManager.Instance.model.addEventListener("myApplyListIsChange",__refishListHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(129,7),__consortiaApplyStatusResult);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _levelBtn.removeEventListener("click",__clickHandler);
         _powerBtn.removeEventListener("click",__clickHandler);
         _selectAll.removeEventListener("click",__clickHandler);
         _agree.removeEventListener("click",__clickHandler);
         _refuse.removeEventListener("click",__clickHandler);
         _setRefuse.removeEventListener("click",__clickHandler);
         _takeIn.removeEventListener("click",__clickHandler);
         _close.removeEventListener("click",__clickHandler);
         _turnPage.removeEventListener("pageChange",__pageChangeHandler);
         ConsortionModelManager.Instance.model.removeEventListener("myApplyListIsChange",__refishListHandler);
         SocketManager.Instance.removeEventListener(PkgEvent.format(129,7),__consortiaApplyStatusResult);
      }
      
      private function __pageChangeHandler(param1:Event) : void
      {
         setList(ConsortionModelManager.Instance.model.getapplyListWithPage(_turnPage.present,_pageCount));
      }
      
      private function __consortiaApplyStatusResult(param1:PkgEvent) : void
      {
         var _loc2_:Boolean = param1.pkg.readBoolean();
         var _loc3_:Boolean = param1.pkg.readBoolean();
         var _loc4_:String = param1.pkg.readUTF();
         MessageTipManager.getInstance().show(_loc4_);
         _setRefuse.selected = !_loc2_;
         PlayerManager.Instance.Self.consortiaInfo.OpenApply = Boolean(_loc2_);
      }
      
      private function __refishListHandler(param1:ConsortionEvent) : void
      {
         _lastSort = "";
         _turnPage.sum = Math.ceil(ConsortionModelManager.Instance.model.myApplyList.length / _pageCount);
         setList(ConsortionModelManager.Instance.model.getapplyListWithPage(_turnPage.present,_pageCount));
      }
      
      private function clearList() : void
      {
         var _loc1_:int = 0;
         _list.disposeAllChildren();
         if(_items)
         {
            _loc1_ = 0;
            while(_loc1_ < _items.length)
            {
               _items[_loc1_] = null;
               _loc1_++;
            }
            _items = null;
         }
         _items = [];
      }
      
      private function setList(param1:Vector.<ConsortiaApplyInfo>) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         clearList();
         var _loc3_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = new TakeInMemberItem();
            _loc2_.info = param1[_loc4_];
            _list.addChild(_loc2_);
            _items.push(_loc2_);
            _loc4_++;
         }
         if(_lastSort != "")
         {
            sort(_lastSort);
         }
      }
      
      private function sort(param1:String) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         _loc5_ = 0;
         while(_loc5_ < _items.length)
         {
            _loc3_ = _items[_loc5_] as TakeInMemberItem;
            _list.removeChild(_loc3_);
            _loc5_++;
         }
         _items.sortOn(param1,2 | 16);
         _loc4_ = 0;
         while(_loc4_ < _items.length)
         {
            _loc2_ = _items[_loc4_] as TakeInMemberItem;
            _list.addChild(_loc2_);
            _loc4_++;
         }
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         var _loc3_:* = param1.currentTarget;
         if(_levelBtn !== _loc3_)
         {
            if(_powerBtn !== _loc3_)
            {
               if(_selectAll !== _loc3_)
               {
                  if(_agree !== _loc3_)
                  {
                     if(_refuse !== _loc3_)
                     {
                        if(_setRefuse !== _loc3_)
                        {
                           if(_takeIn !== _loc3_)
                           {
                              if(_close === _loc3_)
                              {
                                 dispose();
                              }
                           }
                           else
                           {
                              _loc2_ = ComponentFactory.Instance.creatComponentByStylename("wantTakeInFrame");
                              LayerManager.Instance.addToLayer(_loc2_,3,true,1);
                           }
                        }
                        else
                        {
                           SocketManager.Instance.out.sendConsoritaApplyStatusOut(!_setRefuse.selected);
                        }
                     }
                     else
                     {
                        refuse();
                     }
                  }
                  else
                  {
                     agree();
                  }
               }
               else
               {
                  selectAll();
               }
            }
            else
            {
               _lastSort = "FightPower";
               sort(_lastSort);
            }
         }
         else
         {
            _lastSort = "Level";
            sort(_lastSort);
         }
      }
      
      private function selectAll() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(allHasSelected())
         {
            _loc2_ = 0;
            while(_loc2_ < _items.length)
            {
               if(_items[_loc2_])
               {
                  (_items[_loc2_] as TakeInMemberItem).selected = false;
               }
               _loc2_++;
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < _items.length)
            {
               if(_items[_loc1_])
               {
                  (_items[_loc1_] as TakeInMemberItem).selected = true;
               }
               _loc1_++;
            }
         }
      }
      
      private function allHasSelected() : Boolean
      {
         var _loc1_:* = 0;
         _loc1_ = uint(0);
         while(_loc1_ < _items.length)
         {
            if(!(_items[_loc1_] as TakeInMemberItem).selected)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      private function agree() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:Boolean = true;
         _loc3_ = 0;
         while(_loc3_ < _items.length)
         {
            _loc2_ = _items[_loc3_] as TakeInMemberItem;
            if(_loc2_)
            {
               if(_loc2_.selected)
               {
                  SocketManager.Instance.out.sendConsortiaTryinPass(_loc2_.info.ID);
                  _loc1_ = false;
               }
            }
            _loc3_++;
         }
         if(_loc1_)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.myconsortia.AtLeastChoose"));
         }
      }
      
      private function refuse() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:Boolean = true;
         _loc3_ = 0;
         while(_loc3_ < _items.length)
         {
            _loc2_ = _items[_loc3_] as TakeInMemberItem;
            if(_loc2_)
            {
               if((_items[_loc3_] as TakeInMemberItem).selected)
               {
                  SocketManager.Instance.out.sendConsortiaTryinDelete(_loc2_.info.ID);
                  _loc1_ = false;
               }
            }
            _loc3_++;
         }
         if(_loc1_)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.myconsortia.AtLeastChoose"));
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         clearList();
         super.dispose();
         _bg = null;
         _menberListVLine = null;
         _itemBG = null;
         _nameTxt = null;
         _levelTxt = null;
         _powerTxt = null;
         _operateTxt = null;
         _levelBtn = null;
         _powerBtn = null;
         _selectAll = null;
         _agree = null;
         _refuse = null;
         _setRefuse = null;
         _takeIn = null;
         _close = null;
         _list = null;
         _refuseImg = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
