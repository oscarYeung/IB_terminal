package com.henyep.ib.terminal.api.dto.request.client.margin.in.out;

import javax.validation.constraints.NotNull;

import com.henyep.ib.terminal.api.dto.request.BaseDateTimeRequestBodyDto;
import com.henyep.ib.terminal.api.global.Constants;

public class ClientMarginInOutRequestDto extends BaseDateTimeRequestBodyDto {

	private static final long serialVersionUID = -8864837546074457435L;

	@NotNull(message = Constants.ERR_COMMON_CLIENT_CODE_IS_BLANK)
	private String client_code;
	@NotNull(message = Constants.ERR_COMMON_IB_CODE_IS_BLANK)
	private String ib_code;

	public String getClient_code() {
		return client_code;
	}

	public void setClient_code(String client_code) {
		this.client_code = client_code;
	}

	public String getIb_code() {
		return ib_code;
	}

	public void setIb_code(String ib_code) {
		this.ib_code = ib_code;
	}

}
