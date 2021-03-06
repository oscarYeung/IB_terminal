package com.henyep.ib.terminal.api.dto.request.ib.client.link;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

import com.henyep.ib.terminal.api.dto.db.IbClientLinkBean;
import com.henyep.ib.terminal.api.global.Constants;

public class UpdateIbClientLinkDto implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1284030201983472475L;
	
	@NotNull(message = Constants.ERR_IB_CLIENT_LINK_IS_NULL)
	private IbClientLinkBean ibClientLink;

	public IbClientLinkBean getIbClientLink() {
		return ibClientLink;
	}

	public void setIbClientLink(IbClientLinkBean ibClientLink) {
		this.ibClientLink = ibClientLink;
	}
}
